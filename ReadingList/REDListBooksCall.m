//
//  REDListBooksCall.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDListBooksCall.h"
#import "REDServiceCall_Protected.h"
#import "REDServiceResponseProtocol.h"
#import "REDDictionary2ModelFactoryProtocol.h"
#import "REDHTTPRequestFactoryProtocol.h"
#import "NSDictionary+Validation.h"
#import "REDServiceResponse.h"
#import "REDBookDataAccessObject.h"
#import "REDTransactionManager.h"

@interface REDListBooksCall ()

@property (setter=injected_book:) id<REDDictionary2ModelFactoryProtocol> bookFactory;

@end

@implementation REDListBooksCall

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
            [self.bookFactory setInput:[responseObject objectForKey:@"data"]];
            response.data = [self.bookFactory outputForMany];
            [self success:response];
            completion(YES);
        }
    }];
}

@end
