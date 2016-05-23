//
//  REDRealmMigrationImpl.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRealmMigrationV2.h"
#import <Realm/Realm.h>
#import "REDBookDataAccessObject.h"

@interface REDRealmMigrationV2 ()

@property (setter=injected:) id<REDBookDataAccessObject> bookDataAccessObject;

@end

@implementation REDRealmMigrationV2

-(void)migrate {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.schemaVersion = 11;
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < 10) {
            for (id<REDBookProtocol> book in [self.bookDataAccessObject allBooksSorted]) {
                [book setUnprocessed:NO];
            }
        }
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    [RLMRealm defaultRealm];
    
}

@end
