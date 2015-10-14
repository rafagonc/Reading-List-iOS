//
//  REDBookCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDBookProtocol.h"

@interface REDBookCell : UITableViewCell

@property (nonatomic,strong) id<REDBookProtocol> book;

@end
