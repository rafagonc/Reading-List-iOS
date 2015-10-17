//
//  REDPageProgressCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDBookProtocol.h"

@interface REDPageProgressCell : UITableViewCell

@property (nonatomic, weak) id<REDBookProtocol> book;
@property (nonatomic, assign) NSUInteger pages;
@property (nonatomic, assign) NSUInteger pagesRead;

@end
