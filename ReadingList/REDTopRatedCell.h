//
//  REDTopRatedCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDTopRatedBook.h"

@interface REDTopRatedCell : UITableViewCell

@property (nonatomic,weak) id<REDTopRatedBook> book;

@end
