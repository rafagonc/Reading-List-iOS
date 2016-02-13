//
//  REDRLMDefaultDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMDefaultDataAccessObject.h"
#import <Realm/Realm.h>

@interface REDRLMDefaultDataAccessObject ()

@property (nonatomic,strong) RLMRealm *realm;

@end

@implementation REDRLMDefaultDataAccessObject

#pragma mark - constructor
-(instancetype)init {
    if (self = [super init]) {
        self.realm = [RLMRealm defaultRealm];
    } return self;
}

#pragma mark - default
-(void)remove:(id)object {
    [self.realm beginWriteTransaction];
    [self.realm deleteObject:object];
    [self.realm commitWriteTransaction];
}

#pragma mark - entity
-(NSString *)entityName {
    return nil;
}
-(void)dealloc {
}

@end
