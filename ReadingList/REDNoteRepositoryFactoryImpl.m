//
//  REDNoteRepositoryFactory.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDNoteRepositoryFactoryImpl.h"
#import "REDUserProtocol.h"
#import "REDLocalNoteRepository.h"
#import "REDSyncNoteRepository.h"

@interface REDNoteRepositoryFactoryImpl ()

@property (setter=injected:) id<REDUserProtocol> user;

@end

@implementation REDNoteRepositoryFactoryImpl

-(id<REDNoteRepository>)repository {
    if ([self.user isSyncable]) {
        return [[REDLocalNoteRepository alloc] init];
    }
    return [[REDLocalNoteRepository alloc] init];
}

@end
