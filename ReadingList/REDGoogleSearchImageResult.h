//
//  REDGoogleSearchImageResult.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface REDGoogleSearchImageResult : NSObject

#pragma mark - constructor
-(instancetype)initWithDictionary:(NSDictionary *)dict;

#pragma mark - properties
@property (nonatomic,readonly) CGFloat height;
@property (nonatomic,readonly) CGFloat width;
@property (nonatomic,readonly) NSString *url;
@property (nonatomic,readonly) NSString *title;

@end
