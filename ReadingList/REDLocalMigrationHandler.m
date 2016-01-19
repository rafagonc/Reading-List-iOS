//
//  REDLocalMigrationHandler.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLocalMigrationHandler.h"
#import "REDDataStack.h"
#import "REDCloudDataStack.h"
#import "REDCategoryDataAccessObjectImpl.h"
#import "REDBookDataAccessObjectImpl.h"
#import "REDAuthorDataAccessObjectImpl.h"


static NSString * REDLocalMigrationHandlerAlreadyDone = @"REDLocalMigrationHandlerAlreadyDone3310";

@implementation REDLocalMigrationHandler

+(void)migrateBackToLocal {
    //precondition
    BOOL done = [[[NSUserDefaults standardUserDefaults] objectForKey:REDLocalMigrationHandlerAlreadyDone] boolValue];
    if (done) return;
    
    //cloud
    REDBookDataAccessObjectImpl *localBookDataAccessObject = [[REDBookDataAccessObjectImpl alloc] init];
    localBookDataAccessObject.cloudEnabled = NO;
    
    REDCategoryDataAccessObjectImpl *localCategoryDataAccessObject = [[REDCategoryDataAccessObjectImpl alloc] init];
    localCategoryDataAccessObject.cloudEnabled = NO;

    REDAuthorDataAccessObjectImpl *localAuthorDataAccessObject = [[REDAuthorDataAccessObjectImpl alloc] init];
    localAuthorDataAccessObject.cloudEnabled = NO;
    
    for (id<REDCategoryProtocol> category in [localCategoryDataAccessObject list]) {
        [localCategoryDataAccessObject remove:category];
    }
    for (id<REDAuthorProtocol> author in [localAuthorDataAccessObject list]) {
        [localAuthorDataAccessObject remove:author];
    }
    for (id<REDBookProtocol> book in [localBookDataAccessObject list]) {
        [localBookDataAccessObject remove:book];
    }
    
    [[REDDataStack sharedManager] commit];
    
    //locals
    REDBookDataAccessObjectImpl *cloudBookDataAccessObject = [[REDBookDataAccessObjectImpl alloc] init];
    cloudBookDataAccessObject.cloudEnabled = YES;
    REDCategoryDataAccessObjectImpl *cloudCategoryDataAccessObject = [[REDCategoryDataAccessObjectImpl alloc] init];
    cloudCategoryDataAccessObject.cloudEnabled = YES;
    REDAuthorDataAccessObjectImpl *cloudAuthorDataAccessObject = [[REDAuthorDataAccessObjectImpl alloc] init];
    cloudAuthorDataAccessObject.cloudEnabled = YES;

    
    NSArray *books = [cloudBookDataAccessObject list];
    NSArray *authors = [cloudAuthorDataAccessObject list];
    
    NSArray *categories = @[@"Arts & Photohgraphy",
                            @"Biographies & Memories",
                            @"Business & Money",
                            @"Christian Books",
                            @"Comics",
                            @"Children's Book",
                            @"Computers & Technology",
                            @"Cookbooks, Food & Wine",
                            @"Crafts, Hobbies & Home",
                            @"Education & Teaching",
                            @"Engineering & Transportation",
                            @"Gay & Lesbian",
                            @"Health & Fitness",
                            @"History",
                            @"Humor & Entertainment",
                            @"Law",
                            @"Literatute & Fiction",
                            @"Medical Books",
                            @"Mystery, Thriller & Suspense",
                            @"Parenting & Relationships",
                            @"Politics & Social",
                            @"Reference",
                            @"Religion",
                            @"Science & Math",
                            @"Science Fiction",
                            @"Spots & Outdoors",
                            @"Teen & Young Adult",
                            @"Test Preparation",
                            @"Travel"];
    
    for (NSString *name in categories) {
        id<REDCategoryProtocol> category  = [localCategoryDataAccessObject create];
        [category setName:name];
    }
    
    for (id<REDAuthorProtocol> author in authors) {
        if (![author name]) continue;
        id<REDAuthorProtocol> localAuthor = [[localCategoryDataAccessObject listWithPredicate:[NSPredicate predicateWithFormat:@"name LIKE %@", [author name]]] firstObject];
        if (!localAuthor) {
            localAuthor = [localAuthorDataAccessObject create];
        }
        [localAuthor setName:[author name]];
    }
    [[REDDataStack sharedManager] commit];
    
    
    for (id<REDBookProtocol> book in books) {
        if (![book name]) continue;
        id<REDBookProtocol> localBook = [localBookDataAccessObject create];
        [localBook setName:[book name]];
        [localBook setPagesReadValue:[book pagesReadValue]];
        [localBook setPagesValue:[book pagesValue]];
        [localBook setCoverImage:[book coverImage]];
        if ([[book category] name])[localBook setCategory:[[localCategoryDataAccessObject listWithPredicate:[NSPredicate predicateWithFormat:@"name LIKE %@", [[book category] name]]] firstObject]];
        if ([[book author] name])[localBook setAuthor:[[localAuthorDataAccessObject listWithPredicate:[NSPredicate predicateWithFormat:@"name LIKE %@", [[book author] name]]] firstObject]];
    }
    
    [[REDDataStack sharedManager] commit];
    [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:REDLocalMigrationHandlerAlreadyDone];
}


@end
