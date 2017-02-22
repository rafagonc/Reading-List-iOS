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
-(instancetype)initWithUserId:(NSString *)userId book:(NSUInteger)bookId {
    if (self = [super init]) {
        _userId = userId;
        _bookId = bookId;
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
    return @{@"user_id" : self.userId, @"book_id" : @(self.bookId)};
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
