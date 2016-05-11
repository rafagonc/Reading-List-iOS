//
//  REDSyncBookRepository.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/5/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDSyncBookRepository.h"
#import "REDBookDataAccessObject.h"
#import "REDTransactionManager.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDCreateBookRequest.h"
#import "REDListBooksRequest.h"
#import "REDUpdateBookRequest.h"
#import "REDRemoveBookRequest.h"
#import "REDServiceResponseProtocol.h"

@interface REDSyncBookRepository ()

#pragma mark - properties
@property (nonatomic,copy) REDBookRepositoryListCallback listCallback;
@property (nonatomic,copy) REDErrorCallback listErroCallback;

#pragma mark - injceted
@property (setter=injected:) id<REDServiceDispatcherProtocol> serviceDispatcher;
@property (setter=injected:) id<REDTransactionManager> transactionManager;
@property (setter=injected:) id<REDBookDataAccessObject> bookDataAccessObject;

@end

@implementation REDSyncBookRepository

#pragma mark - methods
-(void)createForUser:(id<REDUserProtocol>)user book:(id<REDBookProtocol>)book callback:(REDBookRepositoryCreateUpdateCallback)callback error:(REDErrorCallback)errorCallback {
    @try {
        [self.transactionManager commit];
        callback(book);
        REDCreateBookRequest * bookRequest = [[REDCreateBookRequest alloc] initWithUserId:[user userId] books:@[book]];
        [self.serviceDispatcher callWithRequest:bookRequest withTarget:self andSelector:@selector(response:)];
    } @catch (NSException *exception) {
        errorCallback([exception reason]);
    }
}
-(void)listForUser:(id<REDUserProtocol>)user callback:(REDBookRepositoryListCallback)callback error:(REDErrorCallback)errorCallback {
    @try {
        self.listCallback = callback;
        self.listErroCallback = errorCallback;
        REDListBooksRequest * listRequest = [[REDListBooksRequest alloc] initWithUserId:[user userId]];
        [self.serviceDispatcher callWithRequest:listRequest withTarget:self andSelector:@selector(listResponse:)];
    } @catch (NSException *exception) {
        errorCallback([exception reason]);
    }
}
-(void)removeForUser:(id<REDUserProtocol>)user book:(id<REDBookProtocol>)book callback:(REDBookRepositoryDeleteCallback)callback error:(REDErrorCallback)error {
    @try {
        [self.bookDataAccessObject remove:book];
        callback(book);
        REDRemoveBookRequest * bookRequest = [[REDRemoveBookRequest alloc] initWithUserId:[user userId] book:book];
        [self.serviceDispatcher callWithRequest:bookRequest withTarget:self andSelector:@selector(response:)];
    } @catch (NSException *exception) {
        error([exception reason]);
    }
}
-(void)updateForUser:(id<REDUserProtocol>)user book:(id<REDBookProtocol>)book callback:(REDBookRepositoryCreateUpdateCallback)callback error:(REDErrorCallback)errorCallback {
    @try {
        [self.transactionManager commit];
        callback(book);
        REDUpdateBookRequest * bookRequest = [[REDUpdateBookRequest alloc] initWithUserId:[user userId] book:book];
        [self.serviceDispatcher callWithRequest:bookRequest withTarget:self andSelector:@selector(response:)];
    } @catch (NSException *exception) {
        errorCallback([exception reason]);
    }
}

#pragma mark - resposne
-(void)response:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = [notification object];
    if (response) {
        
    } else {
        
    }
}
-(void)listResponse:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = [notification object];
    if (response) {
        self.listCallback([response data]);
    } else {
        self.listErroCallback([response error]);
    }
}

@end