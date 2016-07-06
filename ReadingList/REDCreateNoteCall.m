//
//  REDCreateNoteCall.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDCreateNoteCall.h"
#import "REDServiceCall_Protected.h"
#import "REDServiceResponseProtocol.h"
#import "REDDictionary2ModelFactoryProtocol.h"
#import "REDHTTPRequestFactoryProtocol.h"
#import "NSDictionary+Validation.h"
#import "REDServiceResponse.h"
#import "REDBookDataAccessObject.h"
#import "REDTransactionManager.h"
#import "REDCreateNoteRequest.h"

@interface REDCreateNoteCall ()

@property (setter=injected:) id<REDTransactionManager> transactionManager;

@end

@implementation REDCreateNoteCall

-(void)startWithRequest:(id<REDRequestProtocol>)request withCompletion:(void (^)(BOOL))completion {
    self.request = request;
    [self call:^(id responseObject, NSError *error) {
        BOOL success = [responseObject[@"success"] boolValue];
        REDServiceResponse * response = [[REDServiceResponse alloc] init];
        if (success) {
            [response setSuccess:YES];
            NSDictionary * note_dict = [responseObject objectForKey:@"data"];
            REDCreateNoteRequest * create_note_request = (REDCreateNoteRequest *)request;
            [self.transactionManager begin];
            [create_note_request.note setText:[note_dict objectForKey:@"text"]];
            [create_note_request.note setIdentifier:[[note_dict objectForKey:@"id"] integerValue]];
            [self.transactionManager commit];
            [response setData:create_note_request.note];
            [self success:response];
            completion(YES);
        } else {
            [response setError:error];
            [response setSuccess:NO];
            [self error:response];
            completion(NO);
        }
    }];
}

@end
