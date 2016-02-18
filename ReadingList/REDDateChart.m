//
//  REDDateChart.m
//  LineChart
//
//  Created by Banco Santander Brasil on 2/15/16.
//  Copyright © 2016 Banco Santander Brasil. All rights reserved.
//

#import "REDDateChart.h"
#import "REDDateChartItem.h"
#import "NSDate+Escort.h"
#import "UIColor+Components.h"

@interface REDDateChart ()

#pragma mark - properties
@property (nonatomic,strong) NSMutableArray <REDDateChartItem *> * items;
@property (nonatomic,assign) CGFloat absoluteWidth;
@property (nonatomic,assign) BOOL fitting;

@end

@implementation REDDateChart

#pragma mark - constructors
-(instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    } return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    } return self;
}
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    } return self;
}
-(void)awakeFromNib {
    [self commonInit];
}
-(void)commonInit {
    self.items = [[NSMutableArray alloc] init];
    self.margin = UIEdgeInsetsMake(5, 5, 10, 10);
    self.backgroundColor = [UIColor clearColor];
    self.lineColor = [UIColor redColor];
    self.gradientStartColor = [UIColor colorWithRed:(239/255.0) green:(81/255.0) blue:(79/255.0) alpha:0.4];
    self.gradientEndColor = [UIColor whiteColor];
    self.fitting = YES;
}

#pragma mark - drawing
-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawGradientForContext:context];
    [self drawLineForContext:context];
    [self drawBallsForContext:context];

}
-(void)drawGradientForContext:(CGContextRef)context {
    CGContextSaveGState(context);
    CGMutablePathRef gradientLines = CGPathCreateMutable();
    CGPathMoveToPoint(gradientLines, NULL, [self xForDate:[self minDate]], self.frame.size.height);
    [self enumerateWithPositionOfItems:^(REDDateChartItem * _Nullable item, CGFloat x, CGFloat y, NSDate *currentDate) {
        CGPathAddLineToPoint(gradientLines, NULL, x, y);
    }];
    CGPathAddLineToPoint(gradientLines, NULL, [self xForDate:[self maxDate]], self.frame.size.height);
    CGPathCloseSubpath(gradientLines);
    CGContextAddPath(context, gradientLines);
    CGContextClip(context);
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, [self gradientColors], NULL, 2);
    CGPoint startPoint = CGPointMake(self.frame.size.width/2,[self yForValue:[self highestValue]] - 2);
    CGPoint endPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient), gradient = NULL;
    CGContextDrawPath(context, kCGPathFill);
    CGContextRestoreGState(context);
}
-(void)drawLineForContext:(CGContextRef)context {
    CGContextSaveGState(context);
    CGMutablePathRef lines = CGPathCreateMutable();
    REDDateChartItem *firstItem = [[self.items filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"date = %@", [self minDate]]] firstObject];
    CGPathMoveToPoint(lines, NULL, [self xForDate:[self minDate]], [self yForValue:firstItem.value
                                                                    ]);
    [self enumerateWithPositionOfItems:^(REDDateChartItem * _Nullable item, CGFloat x, CGFloat y, NSDate *currentDate) {
        CGPathAddLineToPoint(lines, NULL, x, y);
    }];
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextSetLineWidth(context, 2);
    CGContextAddPath(context, lines);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}
-(void)drawBallsForContext:(CGContextRef)context {
    CGContextSaveGState(context);
    [self enumerateWithPositionOfItems:^(REDDateChartItem * _Nullable item, CGFloat x, CGFloat y, NSDate *currentDate) {
        CGMutablePathRef ball = CGPathCreateMutable();
        CGPathAddArc(ball, NULL, x, y, 5, 0, M_PI * 2, 1);
        CGContextAddPath(context, ball);
    }];
    CGContextSetFillColorWithColor(context, [self.lineColor CGColor]);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    //today ball
    [self enumerateWithPositionOfItems:^(REDDateChartItem * _Nullable item, CGFloat x, CGFloat y, NSDate *currentDate) {
        if ([currentDate isEqualToDateIgnoringTime:[NSDate date]]) {
            CGContextSaveGState(context);
            CGMutablePathRef todayBall = CGPathCreateMutable();
            CGPathAddArc(todayBall, NULL, x, y, 8, 0, M_PI * 2, 1);
            CGContextAddPath(context, todayBall);
            CGContextSetStrokeColorWithColor(context, [self.lineColor CGColor]);
            CGContextStrokePath(context);
            CGContextRestoreGState(context);
        }
    }];
}

#pragma mark - positioning
-(CGFloat)xForDate:(NSDate *)date {
    return self.fitting == NO ?  (self.absoluteWidth * [[self minDate] daysBeforeDate:date] + self.margin.left) : (([self usableChartFrame].size.width / [self daysFromMinDateToMaxDate]) * [[self minDate] daysBeforeDate:date] + self.margin.left);
}
-(CGFloat)yForValue:(CGFloat)value {
    return [self usableChartFrame].size.height - ([self usableChartFrame].size.height * ((double)value/(double)[self highestValue])) + self.margin.top;
}
-(void)enumerateWithPositionOfItems:(void(^)(REDDateChartItem * __nullable item, CGFloat x, CGFloat y, NSDate *currentDate))callback {
    NSInteger daysAvailableOnChart = [self daysFromMinDateToMaxDate];
    for (int i = 0; i <= daysAvailableOnChart; i++) {
        NSDate *currentDate = [[self minDate] dateByAddingDays:i];
        REDDateChartItem *item = [[self.items filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"date = %@", currentDate]] firstObject];
        CGFloat x = [self xForDate:currentDate];
        CGFloat y = item ? [self yForValue:item.value] : [self yForValue:0.0];
        callback(item, x, y, currentDate);
    }
    callback = nil;
}
-(void)sizeToFitWithPerDayWidth:(CGFloat)width {
    self.fitting = NO;
    self.absoluteWidth = width;
    [self setNeedsDisplay];
}

#pragma mark - adding
-(void)addValue:(CGFloat)value forDate:(NSDate *)date {
    REDDateChartItem *existingItem = [[self.items filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"date = %@", [date dateAtStartOfDay]]] firstObject];
    if (existingItem) {
        existingItem.value += value;
    } else {
        REDDateChartItem *item = [[REDDateChartItem alloc] initWithDate:[date dateAtStartOfDay] forValue:value];
        [self.items addObject:item];
    }
}

#pragma mark - remove
-(void)clean {
    [self.items removeAllObjects];
    [self setNeedsDisplay];
}

#pragma mark - getters
-(CGRect)usableChartFrame {
    return CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width - self.margin.right, self.frame.size.height - self.margin.top - self.margin.bottom);
}
-(CGFloat)highestValue {
    return [[self.items valueForKeyPath:@"@max.value"] floatValue];
}
-(NSDate *)maxDate {
    return [self.items valueForKeyPath:@"@max.date"];
}
-(NSDate *)minDate {
    return [self.items valueForKeyPath:@"@min.date"];
}
-(NSInteger)daysFromMinDateToMaxDate {
    return [[self minDate] daysBeforeDate:[self maxDate]];
}
-(CGFloat *)gradientColors {
    CGFloat * gradient = (CGFloat *)malloc(sizeof(CGFloat) * 8);
    gradient[0] = self.gradientStartColor.red;
    gradient[1] = self.gradientStartColor.green;
    gradient[2] = self.gradientStartColor.blue;
    gradient[3] = self.gradientStartColor.alpha;
    gradient[4] = self.gradientEndColor.red;
    gradient[5] = self.gradientEndColor.green;
    gradient[6] = self.gradientEndColor.blue;
    gradient[7] = self.gradientEndColor.alpha;
    return gradient;
}
-(CGSize)sizeForChart {
    return self.fitting == NO ? CGSizeMake([self daysFromMinDateToMaxDate] * self.absoluteWidth + self.margin.left + self.margin.right, self.frame.size.height): self.frame.size;
}
-(NSDate *)dateForX:(CGFloat)x {
    return nil;
}

-(void)logValues {
    NSLog(@"%@", [self maxDate]);
    NSLog(@"%@", [self minDate]);
    NSLog(@"%f", [self highestValue]);
    NSLog(@"%ld", (long)[self daysFromMinDateToMaxDate]);
}

#pragma mark - layout
-(void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - dealloc
-(void)dealloc {
    
}

@end
