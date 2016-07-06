//
//  REDUpdateNoteRequest.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDUpdateNoteRequest.h"
#import "REDBookProtocol.h"
#import "REDUserProtocol.h"

@implementation REDUpdateNoteRequest


#pragma mark - constructor
-(instancetype)initWithNote:(id<REDNotesProtocol>)note withText:(NSString *)text {
    if (self = [super init]) {
        _note = note;
        _text = text;
    } return self;
}

#pragma mark - request
-(REDHTTPMethod)HTTPMethod {
    return REDHTTPMethodPUT;
}
-(NSDictionary *)HTTPEncode {
    return @{@"note_id" : @([self.note identifier]) , @"text" : self.text};
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
