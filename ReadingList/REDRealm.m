//
//  REDRealm.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/4/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRealm.h"
#import <Realm/Realm.h>

static RLMRealm * realm;

@implementation REDRealm

#pragma mark - static
+(void)load {
}

#pragma mark - manager
-(void)commit {
    [realm commitWriteTransaction];
}
-(void)begin {
    if (!realm) {
        realm = [RLMRealm defaultRealm];
    }
    [realm beginWriteTransaction];
}

@end
