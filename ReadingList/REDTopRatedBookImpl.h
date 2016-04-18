//
//  REDTopRatedBook.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/16/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "REDTopRatedBook.h"

@interface REDTopRatedBookImpl : NSObject

<REDTopRatedBook>

@property (nonatomic,strong) NSString *bookName;
@property (nonatomic,strong) NSString *authorName;
@property (nonatomic,strong) NSString *categoryName;
@property (nonatomic,assign) CGFloat rating;

@end
