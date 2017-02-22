//
//  REDDateChartItem.m
//  LineChart
//
//  Created by Banco Santander Brasil on 2/15/16.
//  Copyright © 2016 Banco Santander Brasil. All rights reserved.
//

#import "REDDateChartItem.h"

@implementation REDDateChartItem

#pragma mark - constructors
-(instancetype)initWithDate:(NSDate *)date forValue:(CGFloat)value {
    if (self = [super init]) {
        _value = value;
        _date = date;
    } return self;
}

@end
