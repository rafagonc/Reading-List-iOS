   //
//  REDUserUpload.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/1/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDUserUploadImpl.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDUserProtocol.h"
#import "REDServiceDispatcher.h"
#import "REDCreateBookRequest.h"
#import "REDServiceResponseProtocol.h"
#import "REDCreateUserRequest.h"
#import "REDTransactionManager.h"
#import "REDCreateLogRequest.h"
#import "REDListBooksRequest.h"

@interface REDUserUploadImpl () {
    dispatch_group_t services;
    NSError *error;
    BOOL finishUploadingBooks, finishUploadingUser, finishUploadingLogs, finishGettingBooks;
    void(^_callback)(BOOL success, NSError *error);
}

@property (setter=injected1:) id<REDServiceDispatcherProtocol> serviceDispatcher;
@property (setter=injected2:) id<REDUserProtocol> user;
@property (setter=injected3:) id<REDTransactionManager> transactionManager;

@end

@implementation REDUserUploadImpl

#pragma mark - create
-(void)createUser:(id<REDUserProtocol>)user withBooks:(NSArray<id<REDBookProtocol>> *)books andLogs:(NSArray<id<REDReadProtocol>> *)logs andUserId:(NSString *)userId andAuthToken:(NSString *)authToken andAuthTokenSecret:(NSString *)authTokenSecret completion:(void(^)(BOOL success, NSError * error))completion {
    _callback = completion;
    
    [self.transactionManager begin];
    [self.user setAuthToken:authToken andAuthTokenSecret:authTokenSecret andUserId:userId];
    [self.transactionManager commit];
    
    REDCreateUserRequest *createUserRequest = [[REDCreateUserRequest alloc] initWithUser:self.user];
    [self.serviceDispatcher callWithRequest:createUserRequest withTarget:self andSelector:@selector(createUserResponse:)];
    
    REDCreateBookRequest * createBooksRequest = [[REDCreateBookRequest alloc] initWithUserId:userId books:books];
    [self.serviceDispatcher callWithRequest:createBooksRequest withTarget:self andSelector:@selector(createBooksResponse:)];
    
    REDCreateLogRequest * createLogRequest = [[REDCreateLogRequest alloc] initWithUser:[self.user userId] logs:logs];
    [self.serviceDispatcher callWithRequest:createLogRequest withTarget:self andSelector:@selector(createLogsResponse:)];
    
    REDListBooksRequest * listBooksRequest = [[REDListBooksRequest alloc] initWithUserId:[self.user userId]];
    [self.serviceDispatcher callWithRequest:listBooksRequest withTarget:self andSelector:@selector(listBooksResponse:)];
    
}

#pragma mark - response
-(void)createBooksResponse:(NSNotification *)notification {
    finishUploadingBooks = YES;
    id<REDServiceResponseProtocol> resposne = [notification object];
    if ([resposne success]) {
        if (finishUploadingLogs && finishUploadingUser && finishUploadingBooks) _callback(YES, nil);
    } else {
        error = [resposne error];
    }
}
-(void)createUserResponse:(NSNotification *)notification {
    finishUploadingUser = YES;
    id<REDServiceResponseProtocol> resposne = [notification object];
    if ([resposne success]) {
        [self.transactionManager begin];
        [self.user setSyncable:YES];
        [self.transactionManager commit];
        if (finishUploadingLogs && finishUploadingUser && finishUploadingBooks && finishGettingBooks) _callback(YES, nil);
    } else {
        error = [resposne error];
    }
    
}
-(void)createLogsResponse:(NSNotification *)notification {
    finishUploadingLogs = YES;
    id<REDServiceResponseProtocol> resposne = [notification object];
    if ([resposne success]) {
        if (finishUploadingLogs && finishUploadingUser && finishUploadingBooks && finishGettingBooks) _callback(YES, nil);
    } else {
        error = [resposne error];
    }
}
-(void)listBooksResponse:(NSNotification *)notification {
    finishGettingBooks = YES;
    id<REDServiceResponseProtocol> resposne = [notification object];
    if ([resposne success]) {
        if (finishUploadingLogs && finishUploadingUser && finishUploadingBooks && finishGettingBooks) _callback(YES, nil);
    } else {
        error = [resposne error];
    }
}

-(void)dealloc {
    
}

@end
