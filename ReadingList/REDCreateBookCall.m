//
//  REDCreateBookCall.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDCreateBookCall.h"
#import "REDServiceCall_Protected.h"
#import "REDServiceResponseProtocol.h"
#import "REDDictionary2ModelFactoryProtocol.h"
#import "REDHTTPRequestFactoryProtocol.h"
#import "NSDictionary+Validation.h"
#import "REDServiceResponse.h"
#import "REDBookDataAccessObject.h"
#import "REDTransactionManager.h"

@interface REDCreateBookCall ()

@property (setter=injected:) id<REDTransactionManager> transactionManager;
@property (setter=injected1:) id<REDBookDataAccessObject> bookDataAccessObject;

@end

@implementation REDCreateBookCall

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
            response.success = YES;
            [self.transactionManager begin];
            for (id<REDBookProtocol> book in [self.bookDataAccessObject allBooksSorted]) {
                for (NSDictionary * book_dict in responseObject[@"data"]) {
                    if ([[book name] isEqualToString:[[book_dict objectForKey:@"book"] objectForKey:@"name"]]) {
                        [book setIdentifier:[[book_dict objectForKey:@"id"] unsignedIntegerValue]];
                        [book setUnprocessed:NO];
                    }
                }
            }
            [self.transactionManager commit];
            [self success:response];
            completion(YES);
        }
        
    }];
}

@end
