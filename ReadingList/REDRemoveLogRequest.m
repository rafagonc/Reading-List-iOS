//
//  REDRemoveLogRequest.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/6/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRemoveLogRequest.h"
#import "REDRequestProtocol.h"
#import "REDReadProtocol.h"

@implementation REDRemoveLogRequest

#pragma mark - constructor
-(instancetype)initWithUserId:(NSString *)userId log:(id<REDReadProtocol>)read {
    if (self = [super init]) {
        _userId = userId;
        _log = read;
    } return self;
}

#pragma mark - request
-(REDHTTPMethod)HTTPMethod {
    return REDHTTPMethodPOST;
}
-(NSDictionary *)HTTPEncode {
    return @{};
}
-(BOOL)isSyncingRequest {
    return YES;
}
-(NSDictionary *)HTTPHeader {
    return @{};
}
-(NSString *)URL {
    return REDServiceFind(REDServerMetadata_V1, @"log");
}
-(REDSerializer)Serializer {
    return REDJSONSerializer;
}

@end
