//
//  REDPageScrollView.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDPageScrollView.h"

@interface REDPageScrollView () <UIScrollViewDelegate>

@end

@implementation REDPageScrollView

#pragma mark - setters
-(void)setViews:(NSArray<UIView *> *)views {
    for (UIView * view in self.views) [view removeFromSuperview];
    _views = views;
    for (UIView * view in self.views) {
        [self addSubview:view];
    }
    [self setDelegate:self];
    [self.pageControl setNumberOfPages:views.count];
    [self setNeedsLayout];
}

#pragma mark - layout
-(void)layoutSubviews {
    [super layoutSubviews];
    [self.views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(self.frame.size.width * idx, 0, self.frame.size.width, self.frame.size.height - 30);
    }];
    self.contentSize = CGSizeMake(self.frame.size.width * self.views.count, self.frame.size.height);
}

#pragma mark - delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = (int)(self.contentOffset.x/self.frame.size.width);
}

@end
