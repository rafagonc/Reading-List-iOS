//
//  REDRemoveBookRequest.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/5/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRemoveBookRequest.h"

@implementation REDRemoveBookRequest

#pragma mark - constructor
-(instancetype)initWithUserId:(NSString *)userId book:(id<REDBookProtocol>)book {
    if (self = [super init]) {
        _userId = userId;
        _book = book;
    } return self;
}

#pragma mark - request
-(REDHTTPMethod)HTTPMethod {
    return REDHTTPMethodDELETE;
}
-(NSDictionary *)HTTPHeader {
    return @{};
}
-(NSDictionary *)HTTPEncode {
    return @{@"user_id" : self.userId, @"book_name" : [self.book name]};
}
-(REDSerializer)Serializer {
    return REDJSONSerializer;
}
-(NSString *)URL {
    return nil;
}
-(BOOL)isSyncingRequest {
    return YES;
}

@end
