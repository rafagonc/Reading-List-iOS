//
//  REDGoogleSearchImageResult.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDGoogleSearchImageResult.h"
#import "NSDictionary+Validation.h"

@implementation REDGoogleSearchImageResult

#pragma mark - constructor
-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        _height = [[[dict rd_validObjectForKey:@"image"] rd_validObjectForKey:@"height"] floatValue];
        _width = [[[dict rd_validObjectForKey:@"image"] rd_validObjectForKey:@"width"] floatValue];
        _url = [dict rd_validObjectForKey:@"link"];
        _title = [dict rd_validObjectForKey:@"title"];
    } return self;
}

@end
