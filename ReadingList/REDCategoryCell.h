//
//  REDCategoryCell.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 8/16/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDCategoryProtocol.h"
#import <UIKit/UIKit.h>

@class REDCategoryCell;
@protocol REDCategoryCellDelegate <NSObject>

-(void)categoryCellWantsToEditCategory:(REDCategoryCell *)categoryCell;

@end

@interface REDCategoryCell : UITableViewCell

@property (nonatomic,weak) id<REDCategoryProtocol> category;
@property (nonatomic,weak) id<REDCategoryCellDelegate> delegate;


@end
