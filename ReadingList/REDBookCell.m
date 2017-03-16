//
//  REDBookCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookCell.h"
#import "UIColor+ReadingList.h"
#import "UIImageView+WebCache.h"
#import "REDTransactionManager.h"

@interface REDBookCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentCompletedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;

@property (setter=injected:) id<REDTransactionManager> transactionManager;

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
    
    //loved
    if ([book loved]) self.heartImageView.image = [[UIImage imageNamed:@"heart_fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    else self.heartImageView.image = nil;
    
    self.nameLabel.text = book.name;
    
    self.coverImageView.image = [book coverImage] ? [book coverImage] : [UIImage imageNamed:@"404"];
    if ([book coverImage] == nil && [book coverURL].length > 0) {
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[book coverURL]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self.transactionManager begin];
            [book setCoverImage:image];
            [self.transactionManager commit];
        }];
    }
    
    self.percentCompletedLabel.text = [NSString stringWithFormat:@"%lu%% completed", (unsigned long)[book percentage]];
    
    
    if ([book completed]) {
        self.tintColor = [UIColor red_redColor];
        self.accessoryType = UITableViewCellAccessoryCheckmark;
        self.progressLabel.text = [NSString stringWithFormat:@"Finished"];
    } else {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.progressLabel.text = [NSString stringWithFormat:@"Current Page: %lu", (unsigned long)[book pagesReadValue]];
    }
}

#pragma mark - customization



@end
