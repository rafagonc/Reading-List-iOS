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
        _query = [NSString stringWithFormat:@"%@ book cover", query];
        _limit = 8;
    } return self;
}

#pragma mark - request protocol
-(NSDictionary *)HTTPEncode {
    return @{
             @"q" : self.query,
            // @"start" : @(self.offset),
             @"rsz" : @(self.limit),
            // @"v" : @"1.0",
             @"key" : @"AIzaSyAt4RNvJlgXsp-T2sGc8AHoejaMhN5r8IM",
             @"cx" : @"005126926308198905537:wtspnjgitvi",
             @"searchType" : @"image",
             @"alt" : @"json"
             };
}
-(REDHTTPMethod)HTTPMethod {
    return REDHTTPMethodGET;
}
-(REDSerializer)Serializer {
    return REDJSONSerializer;
}
-(NSString *)URL {
    return @"https://www.googleapis.com/customsearch/v1";
}
-(BOOL)isSyncingRequest {
    return NO;
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
