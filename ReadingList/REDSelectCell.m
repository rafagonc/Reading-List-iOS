//
//  REDSelectCellTableViewCell.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 12/21/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDSelectCell.h"

@interface REDSelectCell ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

#pragma mark - properties
@property (nonatomic, copy) Callback c;

@end

@implementation REDSelectCell

#pragma mark - constructor
-(instancetype)initWithTitle:(NSString *)title {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        self.titleLabel.text = title;
    } return self;
}

#pragma mark - selection
-(void)selected {
    if (self.c) self.c();
}

#pragma mark - handle
-(void)handleSelection:(Callback)c {
    self.c = c;
}

@end
