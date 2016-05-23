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
    return @{@"user_id" : self.userId,
             @"book_id" : [self.book identifier] ? @([self.book identifier]) : @0,
             @"pages" : [self.book pagesValue] ? @([self.book pagesValue]) : @0,
             @"pages_read" : [self.book pagesReadValue] ? @([self.book pagesReadValue]) : @0,
             @"snippet" : [self.book snippet] ? [self.book snippet] : @"",
             @"rate" : [self.book rate] ? @([self.book rate]) : @(0.0),
             @"loved" : [self.book loved] ? @([self.book loved]) : @NO,
             @"cover_url" : [self.book coverURL] ? [self.book coverURL] : @""};
}
-(REDSerializer)Serializer {
    return REDJSONSerializer;
}
-(NSString *)URL {
    return REDServiceFind(REDServerMetadata_V1, @"book");
}
-(BOOL)isSyncingRequest {
    return YES;
}
-(BOOL)isTransactionRequest {
    return YES;
}


@end
