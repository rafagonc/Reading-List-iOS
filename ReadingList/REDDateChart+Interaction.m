//
//  REDDateChart+Interaction.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 2/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDDateChart+Interaction.h"
#import "REDDateChartItem.h"

@implementation REDDateChart (Interaction)

#pragma mark - touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    __weak typeof(self) welf = self;
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    [self nearestItemInPosition:location andCallback:^(CGPoint position, REDDateChartItem *item) {
        [self.delegate dateChart:welf isNearItem:item inPosition:position];
    }];
}

#pragma mark - poisition
-(void)nearestItemInPosition:(CGPoint)location andCallback:(void(^)(CGPoint position, REDDateChartItem *item))callback {
    __block REDDateChartItem *nearestItem;
    __block CGFloat minDistance = INT_MAX;
    __block CGPoint position;
    [self enumerateWithPositionOfItems:^(REDDateChartItem * _Nullable item, CGFloat x, CGFloat y, NSDate *currentDate) {
        CGFloat distance = sqrt(pow(location.x - x,2) + pow(location.y - y, 2));
        if (distance < minDistance) {
            minDistance = distance;
            nearestItem = item;
            position = CGPointMake(x, y);
        }
    }];
    callback(position, nearestItem);
    
}

@end
