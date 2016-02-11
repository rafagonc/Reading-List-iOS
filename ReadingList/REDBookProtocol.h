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

#pragma mark - relationships setters
-(void)setAuthor:(id<REDAuthorProtocol>)author;
-(void)setCategory:(id<REDCategoryProtocol>)category;
-(id<REDCategoryProtocol>)category;
-(id<REDAuthorProtocol>)author;

#pragma mark - properties
@property (nonatomic) UIImage * coverImage;
@property (nonatomic) NSString * snippet;
@property (nonatomic) double rate;
@property (nonatomic,readonly) BOOL completed;
@property (nonatomic) NSInteger pagesValue;
@property (nonatomic) NSInteger pagesReadValue;
@property (nonatomic) NSString * language;
@property (nonatomic,readonly) NSUInteger percentage;

@end
