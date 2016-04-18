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
@property (weak, nonatomic) IBOutlet HCSStarRatingView *ratingView;

@end

@implementation REDTopRatedCell

-(void)setBook:(id<REDTopRatedBook>)book {
    _book = book;
    self.ratingView.enabled = NO;
    self.ratingView.value = [book rating];
    self.nameLabel.text = [book name];
    
    /* BEING LAZY */
    UIImage *starImage = [UIImage imageNamed:@"star-template"];
    starImage = [starImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage *highlightedStarImage = [UIImage imageNamed:@"star-highlighted-template"];
    highlightedStarImage = [highlightedStarImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.ratingView.emptyStarImage = starImage;
    self.ratingView.filledStarImage = highlightedStarImage;
    self.ratingView.tintColor = [UIColor red_redColor];
    [self.ratingView addTarget:self action:@selector(ratingDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    /* DONT FEEL BAD, YOU ARE IN A REALLY BAD HANGOVER */
}

@end
