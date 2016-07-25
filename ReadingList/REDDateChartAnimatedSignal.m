//
//  REDDateChartAnimatedSignal.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 3/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDDateChartAnimatedSignal.h"

#define kAnimationDuration 1.0f
#define kAnimationScaleFactor 0.2

@interface REDDateChartAnimatedSignal ()

@property (nonatomic,assign) BOOL deflating;
@property (nonatomic,assign) BOOL stopAnimating;
@property (nonatomic,assign) CGFloat radius;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation REDDateChartAnimatedSignal

#pragma mark - overrides
-(void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.backgroundColor = [UIColor clearColor];
    self.stopAnimating = NO;
    self.deflating = NO;
    self.radius = self.frame.size.width/2 - self.frame.size.width * kAnimationScaleFactor;
}

#pragma mark - draw
-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetFillColorWithColor(context, [self tintColor].CGColor);
    CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2, self.radius, 0, M_PI * 2, YES);
    CGContextFillPath(context);
}

#pragma mark - layout
-(void)layoutSubviews {
    [super layoutSubviews];
    self.radius = self.frame.size.width/2 - self.frame.size.width * kAnimationScaleFactor;
}

#pragma mark - animate
-(void)startInflating {
    if (self.timer) [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f/60.f target:self selector:@selector(inflate) userInfo:@{} repeats:YES];

}
-(void)inflate {
    self.radius += self.deflating ? -.03f : .03f;
    [self setNeedsDisplay];
    if (self.radius > self.frame.size.width/2 && self.deflating == NO) {
        self.deflating = YES;
    } else if (self.radius < self.frame.size.width/2 - self.frame.size.width * kAnimationScaleFactor) {
        self.deflating = NO;
    }

}
-(void)stopInflating {
    [self.timer invalidate];
    self.timer = nil;
}

@end
