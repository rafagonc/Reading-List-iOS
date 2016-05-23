//
//  REDCreateLogCall.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDCreateLogCall.h"
#import "REDServiceCall_Protected.h"
#import "REDServiceResponseProtocol.h"
#import "REDDictionary2ModelFactoryProtocol.h"
#import "REDHTTPRequestFactoryProtocol.h"
#import "NSDictionary+Validation.h"
#import "REDServiceResponse.h"
#import "REDBookDataAccessObject.h"
#import "REDTransactionManager.h"
#import "REDReadDataAccessObject.h"
#import "NSDate+Additions.h"
#import "REDReadProtocol.h"
#import "REDDictionary2ModelFactoryProtocol.h"

@interface REDCreateLogCall ()

@property (setter=injected2:) id<REDReadDataAccessObject> readDataAccessObject;

@end

@implementation REDCreateLogCall

-(void)startWithRequest:(id<REDRequestProtocol>)request withCompletion:(void (^)(BOOL))completion {
    self.request = request;
    [self call:^(id responseObject, NSError *error) {
        REDServiceResponse * response = [[REDServiceResponse alloc] init];
        if (error) {
            completion(NO);
            response.success = NO;
            response.error = error;
            [self error:response];
        } else {
            response.success = YES;
            for (NSDictionary * log_idct in [responseObject objectForKey:@"data"]) {
                id<REDReadProtocol> log = [self.readDataAccessObject logWithIdentifier:[log_idct                                                                                   [@"id"] integerValue]];
                if (log) {
                    [log setIdentifier:[[log_idct objectForKey:@"id"] integerValue]];
                }

            }
            [self success:response];
            completion(YES);
        }
        
    }];
}

@end
