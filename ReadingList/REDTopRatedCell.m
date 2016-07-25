//
//  REDTopRatedCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDTopRatedCell.h"
#import "HCSStarRatingView.h"
#import "UIColor+ReadingList.h"

@interface REDTopRatedCell ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;

@end

@implementation REDTopRatedCell

-(void)setBook:(id<REDTopRatedBook>)book {
    _book = book;
    self.ratingLabel.text = [NSString stringWithFormat:@"%.1f",[book rating]];
    self.nameLabel.text = [book name];
    [self.ratingImageView setTintColor:[UIColor red_redColor]];
    [self.ratingImageView setImage:[[UIImage imageNamed:@"starf"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
}

@end
