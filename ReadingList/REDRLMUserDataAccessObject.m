//
//  REDRLMUserDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMUserDataAccessObject.h"
#import "REDRLMUser.h"
#import "REDTransactionManager.h"

@interface REDRLMUserDataAccessObject ()

@property (setter=injected4:) id<REDTransactionManager> transactionManager;

@end

@implementation REDRLMUserDataAccessObject

#pragma mark - creating
-(id)create {
    RLMRealm *realm = [RLMRealm defaultRealm];
    REDRLMUser * user = [[REDRLMUser alloc] init];
    [self.transactionManager begin];
    [realm addObject:user];
    [self.transactionManager commit];
    return user;
}

#pragma mark - queries
-(NSArray *)list {
    return (NSArray *)[REDRLMUser allObjects];
}
-(NSArray *)listWithPredicate:(NSPredicate *)predicate {
    return (NSArray *)[REDRLMUser objectsWithPredicate:predicate];
}

#pragma mark - user
-(id<REDUserProtocol>)user {
    id<REDUserProtocol> user = [[self list] firstObject];
    if (!user) {
        user = [self create];
    }
    return user;
}


@end
