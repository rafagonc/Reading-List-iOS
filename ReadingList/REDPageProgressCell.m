//
//  REDPageProgressCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDPageProgressCell.h"
#import <Crashlytics/Answers.h>
#import "EDStarRating.h"
#import "UIColor+ReadingList.h"

@interface REDPageProgressCell () <EDStarRatingProtocol>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPageLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet EDStarRating *ratingView;


@end

@implementation REDPageProgressCell

#pragma mark - construcotr
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        self.didChangeRate = NO;
        
        //rating setup
        UIImage *starImage = [UIImage imageNamed:@"star-template"];
        starImage = [starImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage *highlightedStarImage = [UIImage imageNamed:@"star-highlighted-template"];
        highlightedStarImage = [highlightedStarImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.ratingView.starImage = starImage;
        self.ratingView.starHighlightedImage = highlightedStarImage;
        self.ratingView.maxRating = 5.0;
        self.ratingView.displayMode = EDStarRatingDisplayHalf;
        self.ratingView.editable = YES;
        self.ratingView.tintColor = [UIColor red_redColor];
        self.ratingView.delegate = self;
        
    } return self;
}

#pragma mark - setters
-(void)setBook:(id<REDBookProtocol>)book {
    _book = book;
    self.pages = [book pagesValue];
    self.pagesRead = [book pagesReadValue];
    self.ratingView.rating = [book rateValue];
    NSLog(@"%f",[book rateValue]);
    self.slider.minimumValue = 0.0f;
    self.slider.maximumValue = self.pages;
    self.slider.value = (CGFloat)[book pagesReadValue];
    [self updateProgressLabel];
}
-(void)setPages:(NSUInteger)pages {
    _pages = pages;
    self.slider.maximumValue = (CGFloat)self.pages;
}

#pragma mark - actions
-(void)sliderValueChanged:(UISlider *)slider {
    [self setPagesRead:slider.value];
    [self updateProgressLabel];
}

#pragma mark - chain of responsiblity
-(BOOL)setNewValuesOnBook:(id<REDBookProtocol>)book error:(NSError *__autoreleasing *)error {
    [book setPagesReadValue:self.pagesRead];
    [book setRateValue:self.ratingView.rating];
    NSLog(@"%f %f",[book rateValue], self.ratingView.rating);
    if (self.pages == self.pagesRead) {
        [Answers logContentViewWithName:@"Book"
                            contentType:@"Completed"
                              contentId:@""
                       customAttributes:@{}];
    }
    return YES;
}

#pragma makr - selected
-(void)selected {
    if (self.pages == 0) {
        [self.delegate pageProgressCell:self tryingToSetPagesWhileIsZeroForBook:self.book];
    }
}

#pragma mark - delegate
-(void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating {
    self.didChangeRate = YES;
}

#pragma mark - helper methods
-(void)updateProgressLabel {
    self.percentageLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.pagesRead];
}


@end
