//
//  REDBookProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIImage.h>
#import "REDNamable.h"
#import "REDAuthorProtocol.h"
#import "REDCategoryProtocol.h"

@protocol REDBookProtocol <REDNamable>

@optional;

#pragma mark - relationships
@property (nonatomic) id<REDAuthorProtocol> author;
@property (nonatomic) id<REDCategoryProtocol> category;

#pragma mark - properties
@property (nonatomic) UIImage * coverImage;
@property (nonatomic) NSString * snippet;
@property (nonatomic) float rateValue;
@property (nonatomic,readonly) BOOL completed;
@property (nonatomic) NSUInteger pagesValue;
@property (nonatomic) NSUInteger pagesReadValue;
@property (nonatomic) NSString * language;
@property (nonatomic,readonly) NSUInteger percentage;

@end
