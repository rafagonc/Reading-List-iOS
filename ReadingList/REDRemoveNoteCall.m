//
//  REDRemoveNoteCall.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRemoveNoteCall.h"
#import "REDServiceCall_Protected.h"
#import "REDServiceResponseProtocol.h"
#import "REDDictionary2ModelFactoryProtocol.h"
#import "REDHTTPRequestFactoryProtocol.h"
#import "NSDictionary+Validation.h"
#import "REDServiceResponse.h"
#import "REDBookDataAccessObject.h"
#import "REDTransactionManager.h"
#import "REDRemoveNoteRequest.h"
#import "REDNotesDataAccessObject.h"


@interface REDRemoveNoteCall ()

@property (setter=injected1:) id<REDTransactionManager> transactionManager;
@property (setter=injected2:) id<REDNotesDataAccessObject> bookDataAccessObject;

@end

@implementation REDRemoveNoteCall

-(void)startWithRequest:(id<REDRequestProtocol>)request withCompletion:(void (^)(BOOL))completion {
    self.request = request;
    [self call:^(id responseObject, NSError *error) {
        BOOL success = responseObject[@"success"];
        REDServiceResponse * response = [[REDServiceResponse alloc] init];
        if (success) {
            [response setSuccess:YES];
            REDRemoveNoteRequest * note_request = (REDRemoveNoteRequest *)request;
            [self.transactionManager begin];
            [self.bookDataAccessObject remove:note_request.note];
            [self.transactionManager commit];
            [self success:response];
        } else {
            [response setError:error];
            [response setSuccess:NO];
            [self error:response];
        }
    }];
}

@end
