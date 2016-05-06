//
//  REDUpdateBookRequest.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/5/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDUpdateBookRequest.h"

@implementation REDUpdateBookRequest

#pragma mark - constructor
-(instancetype)initWithUserId:(NSString *)userId book:(id<REDBookProtocol>)book {
    if (self = [super init]) {
        _userId = userId;
        _book = book;
    } return self;
}

#pragma mark - request
-(REDHTTPMethod)HTTPMethod {
    return REDHTTPMethodPUT;
}
-(NSDictionary *)HTTPHeader {
    return @{};
}
-(NSDictionary *)HTTPEncode {
    return @{};
}
-(REDSerializer)Serializer {
    return REDJSONSerializer;
}
-(NSString *)URL {
    return nil;
}


@end
