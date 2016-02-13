//
//  REDLocalToRealm.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/12/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLocalToRealm.h"

//realm
#import "REDRLMBookDataAccessObject.h"
#import "REDRLMAuthorDataAccessObject.h"
#import "REDRLMCategoryDataAccessObject.h"
#import "REDRLMReadDataAccessObject.h"
#import "REDRLMUserDataAccessObject.h"

//local
#import "REDBookDataAccessObjectImpl.h"
#import "REDAuthorDataAccessObjectImpl.h"
#import "REDCategoryDataAccessObjectImpl.h"
#import "REDReadDataAccessObjectImpl.h"
#import "REDUserDataAccessObjectImpl.h"

#import "REDTransactionManager.h"

@interface REDLocalToRealm ()

@property (setter=injected:,readonly) id<REDTransactionManager> transactionManager;

@end

static NSString *const REDLocalToRealmDoneKey = @"REDLocalToRealmDoneKey";

@implementation REDLocalToRealm

-(void)migrateToRealm {
    BOOL done = [[[NSUserDefaults standardUserDefaults] objectForKey:REDLocalToRealmDoneKey] boolValue];
    if (!done) {
        
        REDBookDataAccessObjectImpl *bookLocalDAO = [[REDBookDataAccessObjectImpl alloc] init];
        REDCategoryDataAccessObjectImpl *categoryLocalDAO = [[REDCategoryDataAccessObjectImpl alloc] init];
        REDReadDataAccessObjectImpl *readLocalDao = [[REDReadDataAccessObjectImpl alloc] init];
        
        REDRLMBookDataAccessObject *bookRealmDAO = [[REDRLMBookDataAccessObject alloc] init];
        REDRLMAuthorDataAccessObject *authorRealmDAO = [[REDRLMAuthorDataAccessObject alloc] init];
        REDRLMCategoryDataAccessObject *categoryRealmDAO = [[REDRLMCategoryDataAccessObject alloc] init];
        REDRLMReadDataAccessObject *readRealmDao = [[REDRLMReadDataAccessObject alloc] init];
        
        NSArray * categoryList = [categoryLocalDAO list];
        for (id<REDCategoryProtocol> category in categoryList) {
            id<REDCategoryProtocol> realmCategory = [categoryRealmDAO create];
            [self.transactionManager begin];
            [realmCategory setName:[category name]];
            [self.transactionManager commit];
        }
        
        NSArray *localBooks = [bookLocalDAO list];
        for (id<REDBookProtocol> book in localBooks) {
            id<REDBookProtocol> realmBook = [bookRealmDAO create];
            [self.transactionManager begin];
            [realmBook setName:[book name]];
            [realmBook setCoverImage:[book coverImage]];
            //[realmBook setRate:[book rate]];
            [realmBook setSnippet:[book snippet]];
            [realmBook setPagesValue:[book pagesValue]];
            [realmBook setPagesReadValue:[book pagesReadValue]];
            [self.transactionManager commit];
            
            id<REDAuthorProtocol> author = [book author];
            id<REDAuthorProtocol> realmAuthor = [authorRealmDAO create];
            [self.transactionManager begin];
            [realmAuthor setName:[author name]];
            [realmBook setAuthor:realmAuthor];
            [self.transactionManager commit];
            
            id<REDCategoryProtocol> category = [[categoryRealmDAO listWithPredicate:[NSPredicate predicateWithFormat:@"name = %@", [[book category] name]]] firstObject];
            [self.transactionManager begin];
            [realmBook setCategory:category];
            [self.transactionManager commit];
            
        }
        
        NSArray * reads = [readLocalDao list];
        for (id<REDReadProtocol> read in reads) {
            id<REDReadProtocol> realmRead = [readRealmDao create];
            [self.transactionManager begin];
            [realmRead setBook:[read book]];
            [realmRead setDate:[read date]];
            [realmRead setPagesValue:[read pagesValue]];
            [self.transactionManager commit];
        }
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:REDLocalToRealmDoneKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
