//
//  REDLogRepositoryFactoryImpl.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/6/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLogRepositoryFactoryImpl.h"
#import "REDLocalLogRepository.h"
#import "REDSyncLogRepository.h"
#import "REDUserProtocol.h"

@interface REDLogRepositoryFactoryImpl ()

@property (setter=injected:) id<REDUserProtocol> user;

@end

@implementation REDLogRepositoryFactoryImpl

-(id<REDLogRepository>)repository {
//    if ([self.user syncable]) {
//        return [REDSyncLogRepository sharedRepository];
//    }
    return [[REDLocalLogRepository alloc] init];
}

@end
