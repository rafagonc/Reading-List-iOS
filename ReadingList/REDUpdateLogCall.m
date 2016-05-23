//
//  REDUpdateLogCall.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDUpdateLogCall.h"
#import "REDServiceCall_Protected.h"
#import "REDServiceResponseProtocol.h"
#import "REDDictionary2ModelFactoryProtocol.h"
#import "REDHTTPRequestFactoryProtocol.h"
#import "NSDictionary+Validation.h"
#import "REDServiceResponse.h"
#import "REDBookDataAccessObject.h"
#import "REDTransactionManager.h"
#import "REDDictionary2ModelFactoryProtocol.h"

@interface REDUpdateLogCall ()

@property (setter=injected_log:) id<REDDictionary2ModelFactoryProtocol> listLogFactory;

@end

@implementation REDUpdateLogCall

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
            [self.listLogFactory setInput:@[[responseObject objectForKey:@"data"]]];
            [response setData:[self.listLogFactory outputForMany]];
            response.success = YES;
            completion(YES);
        }
        
    }];
}

@end
