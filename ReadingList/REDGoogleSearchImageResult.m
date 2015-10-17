//
//  REDGoogleSearchImageResult.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDGoogleSearchImageResult.h"


@implementation REDGoogleSearchImageResult

#pragma mark - constructor
-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        _height = [dict[@"height"] floatValue];
        _width = [dict[@"width"] floatValue];
        _url = dict[@"url"];
        _title = dict[@"title"];
    } return self;
}

@end
