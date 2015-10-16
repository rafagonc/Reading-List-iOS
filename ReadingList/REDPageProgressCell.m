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
        [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    } return self;
}

#pragma mark - setters
-(void)setBook:(id<REDBookProtocol>)book {
    _book = book;
    self.pages = [book pages];
    self.slider.minimumValue = 0.0f;
    self.slider.maximumValue = self.pages;
    self.slider.value = (CGFloat)[book pagesRead];
    [self updateProgressLabel];
}
-(void)setPages:(NSUInteger)pages {
    _pages = pages;
    self.slider.maximumValue = (CGFloat)self.pages;
}

#pragma mark - actions
-(void)sliderValueChanged:(UISlider *)slider {
    [self.book setPagesRead:slider.value];
    [self updateProgressLabel];
}

#pragma mark - chain of responsiblity
-(BOOL)setNewValuesOnBook:(id<REDBookProtocol>)book error:(NSError *__autoreleasing *)error {
    [self.book setPagesRead:self.slider.value];
    return YES;
}

#pragma mark - helper methods
-(void)updateProgressLabel {
    self.percentageLabel.text = [NSString stringWithFormat:@"%lu%%", [self.book percentage]];
}


@end
