//
//  REDDateChartDelegate.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 2/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@class REDDateChart, REDDateChartItem;

@protocol REDDateChartDelegate <NSObject>

-(void)dateChart:(REDDateChart *)dateChart isNearItem:(REDDateChartItem *)item inPosition:(CGPoint)position;

@end
