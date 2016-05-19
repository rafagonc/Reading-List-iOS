//
//  REDSyncLogRepository.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/6/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDSyncLogRepository.h"
#import "REDReadDataAccessObject.h"
#import "REDTransactionManager.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDListLogsRequest.h"
#import "REDCreateLogRequest.h"
#import "REDRemoveLogRequest.h"
#import "REDServiceResponseProtocol.h"
#import "REDUserProtocol.h"
#import "REDRemoveLogRequest.h"

@interface REDSyncLogRepository ()

#pragma mark - properties
@property (nonatomic,copy) REDLogRepositoryListCallback listCallback;
@property (nonatomic,copy) REDErrorCallback listErrorCallback;

#pragma mark - injected
@property (setter=injected1:) id<REDServiceDispatcherProtocol> serviceDispatcher;
@property (setter=injected2:) id<REDTransactionManager> transactionManager;
@property (setter=injected3:) id<REDReadDataAccessObject> readDataAccessObject;
@property (setter=injected4:) id<REDUserProtocol> user;

@end

@implementation REDSyncLogRepository

#pragma mark - singleton
-(instancetype)init {
    if (self = [super init]) {
        
    } return self;
}
+(REDSyncLogRepository *)sharedRepository {
    static REDSyncLogRepository * repository;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        repository = [[REDSyncLogRepository alloc] init];
    });
    return repository;
}

-(void)createForUser:(id<REDUserProtocol>)user log:(id<REDReadProtocol>)log callback:(REDLogRepositoryCreateCallback)callback error:(REDErrorCallback)error {
    @try {
        [self.transactionManager commit];
        REDCreateLogRequest * createLogRequest = [[REDCreateLogRequest alloc] initWithUser:[self.user userId] logs:@[log]];
        [self.serviceDispatcher callWithRequest:createLogRequest withTarget:self andSelector:@selector(createLogResponse:)];
        callback(log);
    } @catch (NSException *exception) {
        error([NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}]);
    }
}
-(void)removeForUser:(id<REDUserProtocol>)user log:(id<REDReadProtocol>)read callback:(REDLogRepositoryRemoveCallback)callback error:(REDErrorCallback)error {
    @try {
        [self.readDataAccessObject remove:read];
        REDRemoveLogRequest * removeRequest = [[REDRemoveLogRequest alloc] initWithUserId:[self.user userId] log:read];
        [self.serviceDispatcher callWithRequest:removeRequest withTarget:self andSelector:@selector(removeLogResponse:)];
        callback(read);
    } @catch (NSException *exception) {
        error([NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}]);
    }
}
-(void)listForUser:(id<REDUserProtocol>)user callback:(REDLogRepositoryListCallback)callback error:(REDErrorCallback)error {
    @try {
        self.listCallback = callback;
        self.listErrorCallback = error;
        callback([self.readDataAccessObject logsOrderedByDate]);
        REDListLogsRequest *list = [[REDListLogsRequest alloc] initWithUserId:[user userId]];
        [self.serviceDispatcher callWithRequest:list withTarget:self andSelector:@selector(listResponse:)];
    } @catch (NSException *exception) {
        error([NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}]);
    }
}

#pragma mark - response
-(void)createLogResponse:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = [notification object];
    if ([response success]) {
    } else {
    }
}
-(void)listResponse:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = [notification object];
    if ([response success]) {
        self.listCallback([response data]);
    } else {
        self.listErrorCallback([response error]);
    }
}
-(void)removeLogResponse:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = [notification object];
    if ([response success]) {
    } else {
    }
}

@end
