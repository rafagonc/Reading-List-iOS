//
//  REDUITextFieldCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/15/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDUITextFieldCell.h"
#import "UIColor+ReadingList.h"


@implementation REDUITextFieldCell

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        self.textField.tintColor = [UIColor red_redColor];
    } return self;
}

@end
