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
#import "REDReadDataAccessObject.h"
#import "REDTransactionManager.h"

@interface REDRealmMigrationV2 ()
@end

@implementation REDRealmMigrationV2

-(void)migrate {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.schemaVersion = 13;
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < 13) {
        }
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    [RLMRealm defaultRealm];
    
}

@end
