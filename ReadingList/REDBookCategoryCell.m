//
//  REDCategoryCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookCategoryCell.h"
#import "REDValidator.h"
#import "UITextField+DoneButton.h"

@interface REDBookCategoryCell ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

#pragma mark - injected
@property (setter=injected_category:,readonly) id<REDValidator> categoryValidator;

@end

@implementation REDBookCategoryCell

#pragma mark - construcotr
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } return self;
}

#pragma mark - setter
-(void)setCategory:(id<REDCategoryProtocol>)category {
    _category = category;
    self.categoryLabel.text = category ? [category name] : @"Category";
    self.categoryLabel.textColor = category ? [UIColor darkTextColor] : [UIColor lightGrayColor];
}

#pragma mark - chain of responsibility
-(BOOL)setNewValuesOnBook:(id<REDBookProtocol>)book error:(NSError *__autoreleasing *)error {
    if (![self.categoryValidator validate:self.category error:error]) return NO;
    [book setCategory:self.category];
    return YES;
}

#pragma mark - overrides
-(void)selected {
    if ([self.delegate respondsToSelector:@selector(didSelectCategoryCell:)]) {
        [self.delegate didSelectCategoryCell:self];
    }
}


@end
