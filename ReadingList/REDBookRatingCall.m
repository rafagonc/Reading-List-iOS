//
//  REDBookRatingCall.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDBookRatingCall.h"
#import "REDServiceCall_Protected.h"
#import "REDServiceResponseProtocol.h"
#import "REDDictionary2ModelFactoryProtocol.h"
#import "REDHTTPRequestFactoryProtocol.h"
#import "NSDictionary+Validation.h"

@interface REDBookRatingCall ()

@property (setter=injected:, readonly) id<REDServiceResponseProtocol> response;

@end

@implementation REDBookRatingCall

-(void)startWithRequest:(id<REDRequestProtocol>)request withCompletion:(void (^)(BOOL success))completion {
    self.request = request;
    [self call:^(id responseObject, NSError *error) {
        if (error) {
            [self.response setSuccess:NO];
            [self.response setError:error];
            [self error:self.response];
        } else {
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
