//
//  REDBookProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIImage.h>
#import "REDNamable.h"
#import "REDArtistProtocol.h"
#import "REDCategoryProtocol.h"

@protocol REDBookProtocol <REDNamable>

#pragma mark - relationships
@property (nonatomic) id<REDArtistProtocol> artist;
@property (nonatomic) id<REDCategoryProtocol> category;

#pragma mark - properties
@property (nonatomic) UIImage * cover;
@property (nonatomic) BOOL completed;
@property (nonatomic) NSUInteger pages;
@property (nonatomic) NSUInteger pagesRead;
@property (nonatomic) NSString * language;
@property (nonatomic,readonly) NSUInteger percentage;

@end
