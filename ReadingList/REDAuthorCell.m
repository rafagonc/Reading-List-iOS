//
//  REDAuthorCell.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 7/7/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDAuthorCell.h"

@interface REDAuthorCell ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *editImageView;

@end

@implementation REDAuthorCell

-(void)setAuthor:(id<REDAuthorProtocol>)author {
    _author = author;
    self.authorLabel.text = [author name];
    self.editImageView.image = [[UIImage imageNamed:@"edit"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.editImageView setTintColor:[UIColor lightGrayColor]];
}

#pragma mark - acitojns
-(IBAction)editAction:(id)sender {
    [self.delegate authorCell:self wantsToEditAuthor:self.author];
}

@end
