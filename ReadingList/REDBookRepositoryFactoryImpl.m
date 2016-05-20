//
//  REDBookRepositoryFactory.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/5/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDBookRepositoryFactoryImpl.h"
#import "REDLocalBookRepository.h"
#import "REDSyncBookRepository.h"
#import "REDUserProtocol.h"

@interface REDBookRepositoryFactoryImpl ()

@property (setter=injected:) id<REDUserProtocol> user;

@end

@implementation REDBookRepositoryFactoryImpl

-(id<REDBookRepository>)repository {
    if ([self.user syncable])
        return [REDSyncBookRepository sharedRepository];
    return [[REDLocalBookRepository alloc] init];
}

@end
