//
//  REDLibraryCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/16/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDLibraryView.h"
#import "UIStaticTableView.h"

@class REDLibraryCell;
@protocol REDLibraryCellDelegate <NSObject>

-(void)libraryCellDidUpdate:(REDLibraryCell *)cell;

@end

@interface REDLibraryCell : UITableViewCell

<UIStaticTableViewCellCustomizationProtocol>

#pragma mark - ui
@property (nonatomic,weak) REDLibraryView * libraryView;

#pragma makr - properties
@property (nonatomic,weak) id<REDLibraryCellDelegate> delegate;

@end
