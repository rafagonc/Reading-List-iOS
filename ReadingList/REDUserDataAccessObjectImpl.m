//
//  REDUserDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/27/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDUserDataAccessObjectImpl.h"
#import "REDDataStack.h"

@implementation REDUserDataAccessObjectImpl

#pragma mark - user
-(id<REDUserProtocol>)user {
    id<REDUserProtocol> user = [[self list] firstObject];
    if (!user) {
        user = [self create];
        [[REDDataStack sharedManager] commit];
    }
    return user;
}

#pragma mark - overrides
-(NSString *)entityName {
    return @"REDUser";
}

@end
