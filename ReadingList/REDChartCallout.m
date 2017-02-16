//
//  REDChartCallout.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDChartCallout.h"

@interface REDChartCallout ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end

@implementation REDChartCallout

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        
    } return self;
}

#pragma mark - setters
-(void)setItem:(REDDateChartItem *)item {
    _item = item;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    self.dateLabel.text = [formatter stringFromDate:[item date]];
    self.valueLabel.text = [NSString stringWithFormat:@"%lu pages",(unsigned long)item.value];
}

@end
