//
//  REDUpdateUserRequest.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDUpdateUserRequest.h"

@implementation REDUpdateUserRequest

#pragma mark - constructor
-(instancetype)initWithUser:(id<REDUserProtocol>)user {
    if (self = [super init]) {
        _user = user;
    } return self;
}

#pragma mark - request
-(REDHTTPMethod)HTTPMethod {
    return REDHTTPMethodPUT;
}
-(NSDictionary *)HTTPEncode {
    return @{@"user_id" : [self.user userId],
             @"auth_token" : [self.user authToken],
             @"auth_token_secret" : [self.user authTokenSecret],
             @"name" : [self.user name]};
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
    return YES;
}


@end
