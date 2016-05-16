//
//  REDCreateLogRequest.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/6/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDCreateLogRequest.h"

@implementation REDCreateLogRequest

#pragma mark - constructor
-(instancetype)initWithUser:(NSString *)userId logs:(NSArray<id<REDReadProtocol>> *)reads {
    if (self = [super init]) {
        _userId = userId;
        _reads = reads;
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
    return REDServiceFind(REDServerMetadata_V1, @"/log");
}
-(REDSerializer)Serializer {
    return REDJSONSerializer;
}

@end
