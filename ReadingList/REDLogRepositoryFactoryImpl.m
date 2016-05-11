//
//  REDLogRepositoryFactoryImpl.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/6/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLogRepositoryFactoryImpl.h"
#import "REDLocalLogRepository.h"

@implementation REDLogRepositoryFactoryImpl

-(id<REDLogRepository>)repository {
    return [[REDLocalLogRepository alloc] init];
}

@end
