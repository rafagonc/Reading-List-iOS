//
//  REDListLogRequest.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/6/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDListLogRequest.h"

@implementation REDListLogRequest

#pragma mark - constructor
-(instancetype)initWithUserId:(NSString *)userId {
    if (self = [super init]) {
        _userId = userId;
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
    return @"";
}

@end
