//
//  REDCloudMigrationHandler.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/26/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDCloudMigrationHandler.h"
#import "REDDataStack.h"
#import "REDCloudDataStack.h"
#import "REDCategoryDataAccessObjectImpl.h"
#import "REDBookDataAccessObjectImpl.h"
#import "REDAuthorDataAccessObjectImpl.h"

static NSString * REDCloudMigrationHandlerAlreadyDone = @"REDCloudMigrationHandlerAlreadyDone6";

@implementation REDCloudMigrationHandler

+(void)migrateToTheCloud {
    //precondition
    BOOL done = [[[NSUserDefaults standardUserDefaults] objectForKey:REDCloudMigrationHandlerAlreadyDone] boolValue];
    if (done) return;
    
    //cloud
    REDBookDataAccessObjectImpl *cloudBookDataAccessObject = [[REDBookDataAccessObjectImpl alloc] init];
    REDCategoryDataAccessObjectImpl *cloudCategoryDataAccessObject = [[REDCategoryDataAccessObjectImpl alloc] init];
    REDAuthorDataAccessObjectImpl *cloudAuthorDataAccessObject = [[REDAuthorDataAccessObjectImpl alloc] init];
    
    for (id<REDCategoryProtocol> category in [cloudCategoryDataAccessObject list]) {
        [cloudCategoryDataAccessObject remove:category];
    }
    for (id<REDAuthorProtocol> author in [cloudAuthorDataAccessObject list]) {
        [cloudAuthorDataAccessObject remove:author];
    }
    for (id<REDBookProtocol> book in [cloudBookDataAccessObject list]) {
        [cloudBookDataAccessObject remove:book];
    }
    
    //locals
    REDBookDataAccessObjectImpl *localBookDataAccessObject = [[REDBookDataAccessObjectImpl alloc] init];
    localBookDataAccessObject.cloudEnabled = NO;
    REDCategoryDataAccessObjectImpl *localCategoryDataAccessObject = [[REDCategoryDataAccessObjectImpl alloc] init];
    localCategoryDataAccessObject.cloudEnabled = NO;
    REDAuthorDataAccessObjectImpl *localAuthorDataAccessObject = [[REDAuthorDataAccessObjectImpl alloc] init];
    localAuthorDataAccessObject.cloudEnabled = NO;

    
    NSArray *categories = [localCategoryDataAccessObject list];
    NSArray *books = [localBookDataAccessObject list];
    NSArray *authors = [localAuthorDataAccessObject list];
    
    for (id<REDCategoryProtocol> category in categories) {
        id<REDCategoryProtocol> cloudCategory = [[cloudCategoryDataAccessObject listWithPredicate:[NSPredicate predicateWithFormat:@"name LIKE %@", [category name]]] firstObject];
        if (!cloudCategory) {
            cloudCategory = [cloudCategoryDataAccessObject create];
        }
        [cloudCategory setName:[category name]];
    }
    [[REDCloudDataStack sharedManager] commit];
    
    for (id<REDAuthorProtocol> author in authors) {
        id<REDAuthorProtocol> cloudAuthor = [cloudAuthorDataAccessObject create];
        [cloudAuthor setName:[author name]];
    }
    [[REDCloudDataStack sharedManager] commit];

    
    for (id<REDBookProtocol> book in books) {
        id<REDBookProtocol> cloudBook = [cloudBookDataAccessObject create];
        [cloudBook setName:[book name]];
        [cloudBook setPagesReadValue:[book pagesReadValue]];
        [cloudBook setPagesValue:[book pagesValue]];
        [cloudBook setCoverImage:[[UIImage alloc] initWithData:[book coverData]]];
        [cloudBook setCategory:[[cloudCategoryDataAccessObject listWithPredicate:[NSPredicate predicateWithFormat:@"name LIKE %@", [[book category] name]]] firstObject]];
        [cloudBook setAuthor:[[cloudAuthorDataAccessObject listWithPredicate:[NSPredicate predicateWithFormat:@"name LIKE %@", [[book author] name]]] firstObject]];
    }

    [[REDCloudDataStack sharedManager] commit];
    [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:REDCloudMigrationHandlerAlreadyDone];
}

@end
