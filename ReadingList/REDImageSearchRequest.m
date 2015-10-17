//
//  REDImageSearchRequest.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDImageSearchRequest.h"

@interface REDImageSearchRequest ()

@property (nonatomic,assign) NSUInteger offset;

@end

@implementation REDImageSearchRequest

#pragma mark - constructor
-(instancetype)initWithQuery:(NSString *)query {
    if (self = [super init]) {
        _page = -1;
        _query = query;
        _limit = 8;
    } return self;
}

#pragma mark - request protocol
-(NSDictionary *)HTTPEncode {
    return @{
             @"q" : self.query,
             @"start" : @(self.offset),
             @"rsz" : @(self.limit),
             @"v" : @"1.0"
             };
}
-(REDHTTPMethod)HTTPMethod {
    return REDHTTPMethodGET;
}

#pragma mark - methods
-(void)nextPage {
    self.page++;
}

#pragma mark - getters and setters
-(void)setPage:(NSUInteger)page {
    _page = page;
    self.offset = self.limit * page;
}


@end
