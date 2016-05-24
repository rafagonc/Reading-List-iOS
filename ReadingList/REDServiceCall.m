//
//  REDServiceCall.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDServiceCall.h"
#import "REDServiceCall_Protected.h"
#import "REDHTTPRequestFactoryProtocol.h"
#import "REDHTTPRequestProtocol.h"
#import "REDAbstractClassMethodCallingException.h"

@interface REDServiceCall ()

#pragma mark - properties
@property (nonatomic,strong) id<REDHTTPRequestProtocol> HTTPRequest;

#pragma mark - injected
@property (setter=injected:) id<REDHTTPRequestFactoryProtocol> HTTPRequestFactory;

@end

@implementation REDServiceCall

#pragma mark - concrete calling
-(void)call:(REDHTTPRequestProtocolCallback)callback {
    self.HTTPRequest = [self.HTTPRequestFactory HTTPMethodFor:[self.request HTTPMethod]];
    [self.HTTPRequest callWithRequest:self.request andURL:[self.request URL] andCallback:^(id responseObject, NSError *error) {
        callback(responseObject, error);
    }];
}

#pragma mark - service call protocol
-(void)startWithRequest:(id<REDRequestProtocol>)request withCompletion:(void (^)(BOOL success))completion {
    @throw [REDAbstractClassMethodCallingException raise];
}
-(BOOL)canCacheResult {
    @throw [REDAbstractClassMethodCallingException raise];
}

#pragma mark - results
-(void)success:(id<REDServiceResponseProtocol>)response {
    NSLog(@"[SUCCESS] %lu %@", (unsigned long)[self.request HTTPMethod] ,[self.request URL]);
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%lu", (unsigned long)self.request.hash] object:response];
}
-(void)error:(id<REDServiceResponseProtocol>)response {
    NSLog(@"[ERROR] %lu %@", (unsigned long)[self.request HTTPMethod] , [self.request URL]);
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%lu", (unsigned long)self.request.hash] object:response];
}

@end
