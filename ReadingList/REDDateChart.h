//
//  REDDateChart.h
//  LineChart
//
//  Created by Banco Santander Brasil on 2/15/16.
//  Copyright © 2016 Banco Santander Brasil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDDateChartItem.h"
#import "REDDateChartDelegate.h"

@interface REDDateChart : UIView

#pragma mark - customizable
@property (nonatomic,assign) UIEdgeInsets margin;
@property (nonatomic,strong) UIColor * lineColor;
@property (nonatomic,strong) UIColor * gradientStartColor;
@property (nonatomic,strong) UIColor * gradientEndColor;

#pragma mark - properties
@property (nonatomic,weak) id<REDDateChartDelegate> delegate;

#pragma mark - adding
-(void)addValue:(CGFloat)value forDate:(NSDate *)date;
-(void)sizeToFitWithPerDayWidth:(CGFloat)width;

#pragma mark - enumarate
-(void)enumerateWithPositionOfItems:(void(^)(REDDateChartItem * __nullable item, CGFloat x, CGFloat y, NSDate *currentDate))callback;

#pragma mark - remove
-(void)clean;

@end
