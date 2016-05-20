//
//  REDMinimumScaleAnimation.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/19/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDMinimumScaleAnimation.h"

@interface REDMinimumScaleAnimation () {
    BOOL _animating;
}

@property (nonatomic,strong) UIView * view;
@property (nonatomic,assign) BOOL stop;
@property (nonatomic,assign) CGRect initialFrame;

@end

@implementation REDMinimumScaleAnimation

#pragma mark - constructor
-(instancetype)init {
    if (self = [super init]) {
        self.stop = NO;
    } return self;
}

-(void)startAnimating:(UIView *)view {
    _view = view;
    _animating = YES;
    [_view.layer removeAllAnimations];
    if (self.stop) {
        return;
    }
    if ([@(self.initialFrame.size.width) isEqualToNumber:@0]) {
        self.initialFrame = view.frame;
    }
    CGFloat duration = 0.4f;
    CGFloat scaleFactor = 0.2;
    CGFloat newWidthFactor = self.initialFrame.size.width * scaleFactor;
    CGFloat newHeightFactor = self.initialFrame.size.height * scaleFactor;
    [UIView animateWithDuration:duration animations:^{
        view.frame = CGRectMake(self.initialFrame.origin.x - newWidthFactor/2 , self.initialFrame.origin.y - newHeightFactor/2, self.initialFrame.size.width + newWidthFactor, self.initialFrame.size.height + newHeightFactor);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            view.frame = CGRectMake(self.initialFrame.origin.x, self.initialFrame.origin.y, self.initialFrame.size.width, self.initialFrame.size.height);
        } completion:^(BOOL finished) {
            if (self.stop == NO) [self performSelector:@selector(startAnimating:) withObject:view];
        }];
    }];
}
-(void)stopAnimating {
    self.stop = YES;
    _animating = NO;
}
-(BOOL)animating {
    return _animating;
}

@end
