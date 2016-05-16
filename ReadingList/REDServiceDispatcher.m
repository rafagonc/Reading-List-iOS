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

@interface REDServiceDispatcher ()

#pragma mark - hashes in loading
@property (nonatomic,strong) NSMutableSet * hashesInLoading;
@property (nonatomic,strong) NSMutableSet * unprocessedRequests;

@end

@implementation REDServiceDispatcher

#pragma mark - singleton
-(instancetype)init {
    if (self = [super init]) {
        self.hashesInLoading = [[NSMutableSet alloc] init];
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
    NSString *requestHash = [NSString stringWithFormat:@"%lu",(unsigned long)request.hash];
    [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:requestHash object:nil];
    if ([self isHashLoading:request.hash]) return; //Block if the hash is loading, they will recieve the notif anyways
    [self.hashesInLoading addObject:requestHash];
    id<REDServiceCallProtocol> serviceCall = (id<REDServiceCallProtocol>)[NSClassFromString([NSStringFromClass([request class]) stringByReplacingOccurrencesOfString:@"Request" withString:@"Call"]) new];
    [serviceCall startWithRequest:request withCompletion:^(BOOL success){
        (success == NO && [request isSyncingRequest]) ? [self.unprocessedRequests addObject:request] : [self.unprocessedRequests removeObject:request];
        [welf unsubscribeTarget:target fromRequest:request];
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

@end
