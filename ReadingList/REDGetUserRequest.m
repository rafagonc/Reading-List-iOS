//
//  REDGetUserRequest.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDGetUserRequest.h"

@implementation REDGetUserRequest

#pragma mark - constructor
-(instancetype)initWithUserId:(NSString *)user_id {
    if (self = [super init]) {
        _user_id = user_id;
    } return self;
}

#pragma mark - request
-(REDHTTPMethod)HTTPMethod {
    return REDHTTPMethodGET;
}
-(NSDictionary *)HTTPEncode {
    return @{@"user_id" : self.user_id};
}
-(NSDictionary *)HTTPHeader {
    return @{};
}
-(REDSerializer)Serializer {
    return REDJSONSerializer;
}
-(NSString *)URL {
    return REDServiceFind(REDServerMetadata_V1, @"user");
}
-(BOOL)isSyncingRequest {
    return YES;
}
-(BOOL)isTransactionRequest {
    return NO;
}

@end
