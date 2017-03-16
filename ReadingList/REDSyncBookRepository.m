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
@property (setter=injected1:) id<REDServiceDispatcherProtocol> serviceDispatcher;
@property (setter=injected2:) id<REDTransactionManager> transactionManager;
@property (setter=injected3:) id<REDBookDataAccessObject> bookDataAccessObject;

@end

@implementation REDSyncBookRepository

#pragma mark - singleton
+(REDSyncBookRepository *)sharedRepository {
    static REDSyncBookRepository *rep;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rep = [[self alloc] init];
    });
    return rep;
}

#pragma mark - methods
-(void)createForUser:(id<REDUserProtocol>)user book:(id<REDBookProtocol>)book callback:(REDBookRepositoryCreateUpdateCallback)callback error:(REDErrorCallback)errorCallback {
    @try {
        [self.transactionManager commit];
        callback(book);
        REDCreateBookRequest * bookRequest = [[REDCreateBookRequest alloc] initWithUserId:[user userId] books:@[book]];
        [self.serviceDispatcher callWithRequest:bookRequest withTarget:self andSelector:@selector(createBookResponse:)];
    } @catch (NSException *exception) {
        errorCallback([NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}]);
    }
}
-(void)listForUser:(id<REDUserProtocol>)user callback:(REDBookRepositoryListCallback)callback error:(REDErrorCallback)errorCallback {
    @try {
        callback([self.bookDataAccessObject allBooksSorted]);
        self.listCallback = callback;
        self.listErroCallback = errorCallback;
        if (arc4random() % 10 < 4) {
            REDListBooksRequest * listRequest = [[REDListBooksRequest alloc] initWithUserId:[user userId]];
            [self.serviceDispatcher callWithRequest:listRequest withTarget:self andSelector:@selector(listResponse:)];
        }
    } @catch (NSException *exception) {
        errorCallback([NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}]);
    }
}
-(void)removeForUser:(id<REDUserProtocol>)user book:(id<REDBookProtocol>)book callback:(REDBookRepositoryDeleteCallback)callback error:(REDErrorCallback)error {
    @try {
        REDRemoveBookRequest * bookRequest = [[REDRemoveBookRequest alloc] initWithUserId:[user userId] book:[book identifier]];
        [self.serviceDispatcher callWithRequest:bookRequest withTarget:self andSelector:@selector(removeBookResponse:)];
        [self.bookDataAccessObject remove:book];
        callback();
    } @catch (NSException *exception) {
        error([NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}]);
    }
}
-(void)updateForUser:(id<REDUserProtocol>)user book:(id<REDBookProtocol>)book callback:(REDBookRepositoryCreateUpdateCallback)callback error:(REDErrorCallback)errorCallback {
    @try {
        [self.transactionManager commit];
        callback(book);
        
        REDUpdateBookRequest * bookRequest = [[REDUpdateBookRequest alloc] initWithUserId:[user userId] book:book];
        [self.serviceDispatcher callWithRequest:bookRequest withTarget:self andSelector:@selector(updateBookResponse:)];
        
    } @catch (NSException *exception) {
        errorCallback([NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}]);
    }
}

#pragma mark - resposne
-(void)createBookResponse:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = [notification object];
    if (response) {
        
    } else {
        
    }
}
-(void)removeBookResponse:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = [notification object];
    if (response) {
        
    } else {
        
    }
}
-(void)updateBookResponse:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = [notification object];
    if (response) {
        
    } else {
        
    }
}
-(void)listResponse:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = [notification object];
    if (response) {
//        self.listCallback([self.bookDataAccessObject allBooksSorted]);
    } else {
        self.listErroCallback([response error]);
    }
}

@end
