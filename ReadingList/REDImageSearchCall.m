//
//  REDImageSearchCall.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDImageSearchCall.h"
#import "REDServiceCall_Protected.h"
#import "REDServiceResponseProtocol.h"
#import "REDDictionary2ModelFactoryProtocol.h"
#import "REDHTTPRequestFactoryProtocol.h"
#import "NSDictionary+Validation.h"

@interface REDImageSearchCall ()

#pragma mark - injected
@property (setter=injected_googleImage:) id<REDDictionary2ModelFactoryProtocol> googleImageFactory;
@property (setter=injected2:,) id<REDHTTPRequestFactoryProtocol> HTTPRequestFactory;
@property (setter=injected1:,) id<REDServiceResponseProtocol> response;
@end

@implementation REDImageSearchCall

-(void)startWithRequest:(id<REDRequestProtocol>)request withCompletion:(void (^)(BOOL success))completion {
    self.request = request;
    [self call:^(id responseObject, NSError *error) {
        if (error) {
            [self.response setSuccess:NO];
            [self.response setError:error];
            [self error:self.response];
        } else {
            [self.googleImageFactory setInput:[responseObject rd_validObjectForKey:@"items"]];
            [self.response setData:[[self googleImageFactory] outputForMany]];
            [self.response setSuccess:YES];
            [self success:self.response];
        }
        completion(error == nil);
    }];
}
-(BOOL)canCacheResult {
    return NO;
}

@end
