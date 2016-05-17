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

@interface REDUserUploadImpl () {
    dispatch_group_t services;
    NSError *error;
}

@property (setter=injected1:) id<REDServiceDispatcherProtocol> serviceDispatcher;
@property (setter=injected2:) id<REDUserProtocol> user;
@property (setter=injected3:) id<REDTransactionManager> transactionManager;

@end

@implementation REDUserUploadImpl

#pragma mark - create
-(void)createUser:(id<REDUserProtocol>)user withBooks:(NSArray<id<REDBookProtocol>> *)books andLogs:(NSArray<id<REDReadProtocol>> *)logs andUserId:(NSString *)userId andAuthToken:(NSString *)authToken andAuthTokenSecret:(NSString *)authTokenSecret completion:(void(^)(BOOL success, NSError * error))completion {
    
    services = dispatch_group_create();
    
    [self.transactionManager begin];
    [self.user setAuthToken:authToken andAuthTokenSecret:authTokenSecret andUserId:userId];
    [self.transactionManager commit];
    
    dispatch_group_enter(services);
    REDCreateUserRequest *createUserRequest = [[REDCreateUserRequest alloc] initWithUser:self.user];
    [self.serviceDispatcher callWithRequest:createUserRequest withTarget:self andSelector:@selector(createUserResponse:)];
    
    dispatch_group_enter(services);
    REDCreateBookRequest * createBooksRequest = [[REDCreateBookRequest alloc] initWithUserId:userId books:books];
    [self.serviceDispatcher callWithRequest:createBooksRequest withTarget:self andSelector:@selector(createBooksResponse:)];
    
    dispatch_group_notify(services, dispatch_get_main_queue(), ^{
        completion(error == nil, error);
    });
    
}

#pragma mark - response
-(void)createBooksResponse:(NSNotification *)notification {
    id<REDServiceResponseProtocol> resposne = [notification object];
    if ([resposne success]) {
        
    } else {
        error = [resposne error];
    }
    dispatch_group_leave(services);
}
-(void)createUserResponse:(NSNotification *)notification {
    id<REDServiceResponseProtocol> resposne = [notification object];
    if ([resposne success]) {
        [self.transactionManager begin];
        [self.user setSyncable:YES];
        [self.transactionManager commit];
    } else {
        error = [resposne error];
    }
    dispatch_group_leave(services);
}

@end
