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

@interface REDCreateLogCall ()

@property (setter=injected:) id<REDReadDataAccessObject> readDataAccessObject;

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
            NSArray * logs = [responseObject objectForKey:@"data"];
            for (NSDictionary * log_dict in logs) {
                id<REDReadProtocol> read = [self.readDataAccessObject logWithDate:[NSDate sam_dateFromISO8601String:[log_dict objectForKey:@"date"]]];
                [read setIdentifier:log_dict[@"id"]];
            }
            [self success:response];
            completion(YES);
        }
        
    }];
}

@end
