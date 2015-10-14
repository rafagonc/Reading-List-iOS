//
//  REDBookHeaderCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDBookProtocol.h"

@interface REDBookHeaderCell : UITableViewCell

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIButton *coverButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;

#pragma mark - book
@property (nonatomic,weak) id<REDBookProtocol> book;

@end
