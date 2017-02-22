//
//  REDListBooksRequest.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/5/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDListBooksRequest.h"

@implementation REDListBooksRequest

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
-(NSDictionary *)HTTPHeader {
    return @{};
}
-(REDSerializer)Serializer {
    return REDJSONSerializer;
}
-(NSString *)URL {
   return REDServiceFind(REDServerMetadata_V1, @"book");
}
-(BOOL)isSyncingRequest {
    return NO;
}
-(BOOL)isTransactionRequest {
    return NO;
}


@end
