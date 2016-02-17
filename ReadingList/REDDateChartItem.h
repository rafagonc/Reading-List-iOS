//
//  REDDateChartItem.h
//  LineChart
//
//  Created by Banco Santander Brasil on 2/15/16.
//  Copyright © 2016 Banco Santander Brasil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface REDDateChartItem : NSObject

-(instancetype)initWithDate:(NSDate *)date forValue:(CGFloat)value;

@property (nonatomic,assign) CGFloat value;
@property (nonatomic,strong) NSDate *date;

@end
