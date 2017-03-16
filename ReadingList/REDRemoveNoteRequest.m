//
//  REDRemoveNoteRequest.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRemoveNoteRequest.h"
#import "REDBookProtocol.h"
#import "REDUserProtocol.h"

@interface REDRemoveNoteRequest ()

@property (setter=injected:) id<REDUserProtocol> user;

@end

@implementation REDRemoveNoteRequest

#pragma mark - constructor
-(instancetype)initWithNote:(id<REDNotesProtocol>)note {
    if (self = [super init]) {
        _note = note;
    } return self;
}

#pragma mark - request
-(REDHTTPMethod)HTTPMethod {
    return REDHTTPMethodDELETE;
}
-(NSDictionary *)HTTPEncode {
    return @{@"note_id" : @([self.note identifier])};
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
