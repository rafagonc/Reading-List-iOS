//
//  REDTransientBookCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/26/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDTransientBookCell.h"
#import "UIImageView+WebCache.h"


@interface REDTransientBookCell ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverimageView;

@end

@implementation REDTransientBookCell

#pragma mark - setters
-(void)setBook:(REDTransientBook *)book {
    _book = book;
    self.titleLabel.text = [book title];
    self.authorLabel.text = [book authorsName];
    [self.coverimageView sd_setImageWithURL:[NSURL URLWithString:[book imageURL]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [book setCoverImage:image];
    }];
}

#pragma mark - action
-(IBAction)addAction:(id)sender {
    [self.delegate transientBookCell:self wantsToAddTransientBook:self.book];
}

@end
