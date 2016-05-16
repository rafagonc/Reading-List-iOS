//
//  REDRealmMigrationImpl.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRealmMigrationV2.h"
#import <Realm/Realm.h>

@implementation REDRealmMigrationV2

-(void)migrate {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.schemaVersion = 7;
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < 1) {
        }
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    [RLMRealm defaultRealm];
    
}

@end
