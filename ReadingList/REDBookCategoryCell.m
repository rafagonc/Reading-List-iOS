//
//  REDCategoryCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookCategoryCell.h"
#import "UITextField+DoneButton.h"

@interface REDBookCategoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end

@implementation REDBookCategoryCell

#pragma mark - construcotr
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
    } return self;
}

#pragma mark - setter
-(void)setCategory:(id<REDCategoryProtocol>)category {
    _category = category;
    self.categoryLabel.text = [category name];
}

@end
