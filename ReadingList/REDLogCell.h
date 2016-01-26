//
//  REDLogCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDReadProtocol.h"

@interface REDLogCell : UITableViewCell

#pragma mark - properties
@property (nonatomic,weak) id<REDReadProtocol>read;

@end
