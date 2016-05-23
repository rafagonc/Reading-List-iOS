//
//  REDRLMDefaultDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMDefaultDataAccessObject.h"
#import <Realm/Realm.h>
#import "REDTransactionManager.h"

@interface REDRLMDefaultDataAccessObject ()

@property (strong,nonatomic) RLMRealm * realm;
@property (setter=injected:) id<REDTransactionManager> transactionManager;

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
    [self.transactionManager begin];
    [self.realm deleteObject:object];
    [self.transactionManager commit];
}

#pragma mark - entity
-(NSString *)entityName {
    return nil;
}
-(void)dealloc {
}

@end
