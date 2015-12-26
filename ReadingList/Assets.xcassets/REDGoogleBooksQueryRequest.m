//
//  REDAmazonProductSearch.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDGoogleBooksQueryRequest.h"

@implementation REDGoogleBooksQueryRequest

#pragma mark - constructor
-(instancetype)initWithQuery:(NSString *)query {
    if (self = [super init]) {
        _query = query;
    } return self;
}

#pragma mark - request protocol
-(REDHTTPMethod)HTTPMethod {
    return REDHTTPMethodGET;
}
-(NSDictionary *)HTTPHeader {
    return @{};
}
-(NSDictionary *)HTTPEncode {
    return @{@"q" : [NSString stringWithFormat:@"%@", self.query], @"key" : @"AIzaSyCB9siucRVNmW3r8PLDcZu2DnZiofC68U8"};
}
-(REDSerializer)Serializer {
    return REDJSONSerializer;
}
-(NSString *)URL {
    return @"https://www.googleapis.com/books/v1/volumes";
}


@end
