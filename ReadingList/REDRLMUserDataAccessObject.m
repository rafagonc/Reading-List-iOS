//
//  REDRLMUserDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMUserDataAccessObject.h"
#import "REDRLMUser.h"

@implementation REDRLMUserDataAccessObject

#pragma mark - creating
-(id)create {
    return [[REDRLMUser alloc] init];
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
//        [[REDDataStack sharedManager] commit];
    }
    return user;
}


@end
