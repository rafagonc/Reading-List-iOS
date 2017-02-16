//
//  REDBookRatingRequest.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDBookRatingRequest.h"

@implementation REDBookRatingRequest

-(instancetype)initWithBook:(id<REDBookProtocol>)book andRating:(CGFloat)rating {
    if (self = [super init]) {
        _book = book;
        _rating = rating;
    } return self;
}

-(REDSerializer)Serializer {
    return REDJSONSerializer;
}
-(REDHTTPMethod)HTTPMethod {
    return REDHTTPMethodPOST;
}
-(NSDictionary *)HTTPEncode {
    return @{@"book_name" : [self.book name],
             @"author_name" : [[self.book author] name],
             @"category_name" : [[self.book category] name],
             @"rating" : @(self.rating)};
}
-(NSDictionary *)HTTPHeader {
    return @{};
}
-(NSString *)URL {
    return REDServiceFind(REDServerMetadata_V1, @"rating");
}
-(BOOL)isSyncingRequest {
    return NO;
}
-(BOOL)isTransactionRequest {
    return NO;
}

@end
