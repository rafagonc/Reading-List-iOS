//
//  REDCreateNoteRequest.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDCreateNoteRequest.h"
#import "REDBookProtocol.h"
#import "REDUserProtocol.h"

@interface REDCreateNoteRequest ()

@property (setter=injected:) id<REDUserProtocol> user;

@end

@implementation REDCreateNoteRequest

#pragma mark - constructor
-(instancetype)initWithNote:(id<REDNotesProtocol>)note {
    if (self = [super init]) {
        _note = note;
    } return self;
}

#pragma mark - request
-(REDHTTPMethod)HTTPMethod {
    return REDHTTPMethodPOST;
}
-(NSDictionary *)HTTPEncode {
    return @{@"text" : [self.note text], @"book_id": @([[self.note book] identifier]), @"user_id" : [self.user userId]};
}
-(NSDictionary *)HTTPHeader {
    return @{};
}
-(REDSerializer)Serializer {
    return REDJSONSerializer;
}
-(NSString *)URL {
    return REDServiceFind(REDServerMetadata_V1, @"note");
}
-(BOOL)isSyncingRequest {
    return YES;
}
-(BOOL)isTransactionRequest {
    return YES;
}


@end
