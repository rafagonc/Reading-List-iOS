//
//  REDListLogsCall.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDListLogsCall.h"
#import "REDServiceCall_Protected.h"
#import "REDServiceResponseProtocol.h"
#import "REDDictionary2ModelFactoryProtocol.h"
#import "REDHTTPRequestFactoryProtocol.h"
#import "NSDictionary+Validation.h"
#import "REDServiceResponse.h"
#import "REDBookDataAccessObject.h"
#import "REDTransactionManager.h"

@interface REDListLogsCall ()

@property (setter=injected_log:) id<REDDictionary2ModelFactoryProtocol> logFactory;

@end

@implementation REDListLogsCall

-(void)startWithRequest:(id<REDRequestProtocol>)request withCompletion:(void (^)(BOOL))completion {
    self.request = request;
    [self call:^(id responseObject, NSError *error) {
        REDServiceResponse * response = [[REDServiceResponse alloc] init];
        if (error) {
            response.success = NO;
            response.error = error;
            [self error:response];
            completion(NO);
        } else {
            [self.logFactory setInput:responseObject[@"data"]];
            [response setData:[self.logFactory outputForMany]];
            response.success = YES;
            [self success:response];
            completion(YES);
        }
        
    }];
}

@end
