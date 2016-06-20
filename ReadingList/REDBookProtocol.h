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
#import "REDNotesProtocol.h"

@protocol REDBookProtocol <REDNamable>

@optional;

#pragma mark - relationships setters
-(void)setAuthor:(_Nonnull id<REDAuthorProtocol>)author;
-(void)setCategory:(_Nonnull id<REDCategoryProtocol>)category;
-(_Nullable id<REDCategoryProtocol>)category;
-(_Nullable id<REDAuthorProtocol>)author;
-(NSMutableArray <id<REDNotesProtocol>> * _Nullable )notes;
-(BOOL)hasRate;

#pragma mark - properties
@property (nonatomic) BOOL unprocessed;
@property (nonatomic) NSInteger identifier;
@property (nonatomic, nullable) UIImage * coverImage;
@property (nonatomic, nullable) NSString * snippet;
@property (nonatomic) double rate;
@property (nonatomic) BOOL loved;
@property (nonatomic,readonly) BOOL completed;
@property (nonatomic) NSInteger pagesValue;
@property (nonatomic) NSInteger pagesReadValue;
@property (nonatomic, nullable) NSString * language;
@property (nonatomic,readonly) NSUInteger percentage;
@property (nonatomic, nullable) NSString *coverURL;

@end
