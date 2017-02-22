//
//  REDSelectCellTableViewCell.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 12/21/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIStaticTableView.h"

typedef void(^Callback)();

@interface REDSelectCell : UITableViewCell

#pragma mark - constructor
-(instancetype)init UNAVAILABLE_ATTRIBUTE;
-(instancetype)initWithTitle:(NSString *)title;

#pragma mark - selected
-(void)handleSelection:(Callback)c;

@end
