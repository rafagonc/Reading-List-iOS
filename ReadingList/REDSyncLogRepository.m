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
#import "REDListLogRequest.h"
#import "REDCreateLogRequest.h"
#import "REDRemoveLogRequest.h"
#import "REDServiceResponseProtocol.h"

@interface REDSyncLogRepository ()

#pragma mark - properties
@property (nonatomic,copy) REDLogRepositoryListCallback listCallback;
@property (nonatomic,copy) REDErrorCallback listErrorCallback;

#pragma mark - injected
@property (setter=injected1:) id<REDServiceDispatcherProtocol> serviceDispatcher;
@property (setter=injected2:) id<REDTransactionManager> transactionManager;
@property (setter=injected3:) id<REDReadDataAccessObject> readDataAccessObject;

@end

@implementation REDSyncLogRepository

-(void)createForUser:(id<REDUserProtocol>)user log:(id<REDReadProtocol>)log callback:(REDLogRepositoryCreateCallback)callback error:(REDErrorCallback)error {
    @try {
        [self.transactionManager commit];
        callback(log);
    } @catch (NSException *exception) {
        error([NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}]);
    }
}
-(void)removeForUser:(id<REDUserProtocol>)user log:(id<REDReadProtocol>)read callback:(REDLogRepositoryRemoveCallback)callback error:(REDErrorCallback)error {
    @try {
        [self.readDataAccessObject remove:read];
        callback(read);
    } @catch (NSException *exception) {
        error([NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}]);
    }
}
-(void)listForUser:(id<REDUserProtocol>)user callback:(REDLogRepositoryListCallback)callback error:(REDErrorCallback)error {
    @try {
        self.listCallback = callback;
        self.listErrorCallback = error;
        REDListLogRequest *list = [[REDListLogRequest alloc] initWithUserId:[user userId]];
        [self.serviceDispatcher callWithRequest:list withTarget:self andSelector:@selector(listResponse:)];
    } @catch (NSException *exception) {
        error([NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}]);
    }
}

#pragma mark - response
-(void)listResponse:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = [notification object];
    if ([response success]) {
        self.listCallback([response data]);
    } else {
        self.listErrorCallback([response error]);
    }
}
-(void)response:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = [notification object];
    if ([response success]) {
    } else {
    }
}

@end
