//
//  REDGetUserCall.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDGetUserCall.h"
#import "REDServiceCall_Protected.h"
#import "REDServiceResponseProtocol.h"
#import "REDDictionary2ModelFactoryProtocol.h"
#import "REDHTTPRequestFactoryProtocol.h"
#import "NSDictionary+Validation.h"
#import "REDServiceResponse.h"
#import "REDBookDataAccessObject.h"
#import "REDTransactionManager.h"
#import "REDUserProtocol.h"
#import "REDTransactionManager.h"

@interface REDGetUserCall ()

@property (setter=injected1:) id<REDTransactionManager> transactionManager;
@property (setter=injected2:) id<REDUserProtocol> user;

@end

@implementation REDGetUserCall

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
            [self.transactionManager begin];
            [self.user setName:[[responseObject objectForKey:@"data"] objectForKey:@"name"]];
            [self.transactionManager commit];
            response.success = YES;
            [self success:response];
            completion(YES);
        }
        
    }];
}

@end
