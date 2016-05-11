//
//  REDLocalBookRepository.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/5/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLocalBookRepository.h"
#import "REDBookDataAccessObject.h"
#import "REDTransactionManager.h"

@interface REDLocalBookRepository ()

@property (setter=injected:) id<REDTransactionManager> transactionManager;
@property (setter=injected:) id<REDBookDataAccessObject> bookDataAccessObject;

@end

@implementation REDLocalBookRepository

#pragma mark - methods
-(void)createForUser:(id<REDUserProtocol>)user book:(id<REDBookProtocol>)book callback:(REDBookRepositoryCreateUpdateCallback)callback error:(REDErrorCallback)errorCallback {
    @try {
        [self.transactionManager commit];
        callback(book);
    } @catch (NSException *exception) {
        errorCallback([exception reason]);
    }
}
-(void)listForUser:(id<REDUserProtocol>)user callback:(REDBookRepositoryListCallback)callback error:(REDErrorCallback)errorCallback {
    @try {
        callback([self.bookDataAccessObject allBooksSorted]);
    } @catch (NSException *exception) {
        errorCallback([exception reason]);
    }
}
-(void)removeForUser:(id<REDUserProtocol>)user book:(id<REDBookProtocol>)book callback:(REDBookRepositoryDeleteCallback)callback error:(REDErrorCallback)error {
    @try {
        [self.bookDataAccessObject remove:book];
        callback(book);
    } @catch (NSException *exception) {
        error([exception reason]);
    }
}
-(void)updateForUser:(id<REDUserProtocol>)user book:(id<REDBookProtocol>)book callback:(REDBookRepositoryCreateUpdateCallback)callback error:(REDErrorCallback)errorCallback {
    @try {
        [self.transactionManager commit];
        callback(book);
    } @catch (NSException *exception) {
        errorCallback([exception reason]);
    }
}

@end
