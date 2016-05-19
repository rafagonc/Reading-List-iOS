//
//  REDListLogRequest.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/6/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDListLogsRequest.h"

@implementation REDListLogsRequest

#pragma mark - constructor
-(instancetype)initWithUserId:(NSString *)userId {
    if (self = [super init]) {
        _userId = userId;
    } return self;
}

#pragma mark - request
-(REDHTTPMethod)HTTPMethod {
    return REDHTTPMethodGET;
}
-(NSDictionary *)HTTPEncode {
    return @{@"user_id" : self.userId};
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
