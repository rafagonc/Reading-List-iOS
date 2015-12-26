//
//  REDGoodReadsQueryCall.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDGoogleBooksQueryCall.h"
#import "REDServiceCall_Protected.h"
#import "REDServiceResponseProtocol.h"
#import "REDDictionary2ModelFactoryProtocol.h"
#import "REDHTTPRequestFactoryProtocol.h"
#import "NSDictionary+Validation.h"

@interface REDGoogleBooksQueryCall ()

#pragma mark - injected
@property (setter=injected_googleBooks:,readonly) id<REDDictionary2ModelFactoryProtocol> googleBooksFactory;
@property (setter=injected:, readonly) id<REDHTTPRequestFactoryProtocol> HTTPRequestFactory;
@property (setter=injected:, readonly) id<REDServiceResponseProtocol> response;

@end

@implementation REDGoogleBooksQueryCall

-(void)startWithRequest:(id<REDRequestProtocol>)request withCompletion:(void (^)(void))completion {
    self.request = request;
    [self call:^(id responseObject, NSError *error) {
        if (error) {
            [self.response setSuccess:NO];
            [self.response setError:error];
            [self error:self.response];
        } else {
            [self.googleBooksFactory setInput:[responseObject rd_validObjectForKey:@"items"]];
            [self.response setData:[self.googleBooksFactory outputForMany]];
            [self.response setSuccess:YES];
            [self success:self.response];
        }
    }];
}
-(BOOL)canCacheResult {
    return NO;
}

@end
