//
//  REDServiceDispatcher.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDServiceDispatcher.h"
#import "REDServiceCallFactory.h"
#import "REDHTTPEncodeProtocol.h"
#import "REDRequestProtocol.h"
#import "REDListLogsRequest.h"
#import "REDListBooksRequest.h"

@interface REDServiceDispatcher ()

#pragma mark - hashes in loading
@property (nonatomic,strong) NSMutableSet * hashesInLoading;
@property (nonatomic,strong) NSMutableSet * unprocessedRequests;
@property (nonatomic,strong) NSMutableSet * processingRequestClassesNames;

@end

@implementation REDServiceDispatcher

#pragma mark - singleton
-(instancetype)init {
    if (self = [super init]) {
        self.hashesInLoading = [[NSMutableSet alloc] init];
        self.processingRequestClassesNames = [[NSMutableSet alloc] init];
    } return self;
}
+(REDServiceDispatcher *)sharedDispatcher {
    static REDServiceDispatcher *proxy;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        proxy = [[REDServiceDispatcher alloc] init];
    });
    return proxy;
}

#pragma mark - block calling
-(BOOL)isHashLoading:(NSUInteger)hash {
    for (NSString *s in self.hashesInLoading) {
        if ([[NSString stringWithFormat:@"%lu", (unsigned long)hash] isEqualToString:s]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - calling
-(void)callWithRequest:(id<REDRequestProtocol>)request withTarget:(id)target andSelector:(SEL)selector {
    __weak typeof(self) welf = self;
    [self startStatusBarLoading:request];
    if ([self isRequestHappeningNow:request] == YES && ([request isKindOfClass:[REDListLogsRequest class]] || [request isKindOfClass:[REDListBooksRequest class]])) return;
    [self registerClasseName:request];
    NSString *requestHash = [NSString stringWithFormat:@"%lu",(unsigned long)request.hash];
    [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:requestHash object:nil];
    if ([self isHashLoading:request.hash]) return; //Block if the hash is loading, they will recieve the notif anyways
    [self.hashesInLoading addObject:requestHash];
    id<REDServiceCallProtocol> serviceCall = (id<REDServiceCallProtocol>)[NSClassFromString([NSStringFromClass([request class]) stringByReplacingOccurrencesOfString:@"Request" withString:@"Call"]) new];
    [serviceCall startWithRequest:request withCompletion:^(BOOL success){
        (success == NO && [request isSyncingRequest]) ? [self.unprocessedRequests addObject:request] : [self.unprocessedRequests removeObject:request];
        [welf unregisterClasseName:request];
        [welf unsubscribeTarget:target fromRequest:request];
        [welf stopStatusBarLoading];
        [welf.hashesInLoading removeObject:requestHash];
    }];
}
-(void)unsubscribeTarget:(id)target fromRequest:(id<REDRequestProtocol>)request {
    [[NSNotificationCenter defaultCenter] removeObserver:target name:[NSString stringWithFormat:@"%lu",(unsigned long)request.hash] object:nil];
}

#pragma mark - process
-(void)processUnprocessedRequestIfNeeded {
    for (id<REDRequestProtocol> request in self.unprocessedRequests) {
        [self callWithRequest:request withTarget:nil andSelector:nil];
    }
}

#pragma mark - methods
-(BOOL)isRequestHappeningNow:(id<REDRequestProtocol>)request {
    return [[self.processingRequestClassesNames filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"isTransactionRequest = YES"]] count] > 0;
}
-(void)registerClasseName:(id<REDRequestProtocol>)reqiest {
    [self.processingRequestClassesNames addObject:reqiest];
}
-(void)unregisterClasseName:(id<REDRequestProtocol>)reqiest {
    [self.processingRequestClassesNames removeObject:reqiest];
}

#pragma mark - start syncing loading
-(void)startStatusBarLoading:(id<REDRequestProtocol>)request {
    if ([request isSyncingRequest])
    [[NSNotificationCenter defaultCenter] postNotificationName:REDStartStatusBarSyncingLoadingViewNotificationKey object:request];
}
-(void)stopStatusBarLoading {
    [[NSNotificationCenter defaultCenter] postNotificationName:REDStopStatusBarSyncingLoadingViewNotificationKey object:nil];
}

@end
