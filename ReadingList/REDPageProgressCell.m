//
//  REDPageProgressCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDPageProgressCell.h"

@interface REDPageProgressCell ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPageLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;


@end

@implementation REDPageProgressCell

#pragma mark - construcotr
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
    } return self;
}

#pragma mark - setters
-(void)setBook:(id<REDBookProtocol>)book {
    _book = book;
    self.slider.minimumValue = 0.0f;
    self.slider.maximumValue = (CGFloat)[book pages];
    self.slider.value = (CGFloat)[book pagesRead];
    self.percentageLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[book percentage]];
}


@end
