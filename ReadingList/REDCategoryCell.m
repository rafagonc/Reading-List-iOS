//
//  REDCategoryCell.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 8/16/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDCategoryCell.h"

@interface REDCategoryCell ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIImageView *editImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end

@implementation REDCategoryCell

#pragma mark - setters
-(void)setCategory:(id<REDCategoryProtocol>)category {
    _category = category;
    self.nameLabel.text = [category name];
    self.editImageView.image = [[UIImage imageNamed:@"edit"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.editImageView setTintColor:[UIColor lightGrayColor]];
    [self.editImageView setHidden:![category custom]];
    [self.editButton setHidden:![category custom]];
}

#pragma mark - action
-(IBAction)editAction:(id)sender {
    [self.delegate categoryCellWantsToEditCategory:self];
}

@end
