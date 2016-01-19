//
//  REDBookCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookCell.h"
#import "UIColor+ReadingList.h"

@interface REDBookCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@end

@implementation REDBookCell

#pragma mark - override
-(void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - setters
-(void)setBook:(id<REDBookProtocol>)book {
    _book = book;
    self.nameLabel.text = book.name;
    self.coverImageView.image = [book coverImage] ? [book coverImage] : [UIImage imageNamed:@"404"];
    if ([book completed]) {
        self.tintColor = [UIColor red_redColor];
        self.accessoryType = UITableViewCellAccessoryCheckmark;
        self.progressLabel.text = [NSString stringWithFormat:@"%lu%% completed", (unsigned long)[book percentage]];
    } else {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.progressLabel.text = [NSString stringWithFormat:@"Current Page: %lu", (unsigned long)[book pagesReadValue]];
    }
}

#pragma mark - customization



@end
