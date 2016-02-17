//
//  REDChartViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/28/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDChartViewController.h"
#import "REDReadDataAccessObject.h"
#import "REDDateChart.h"
#import "REDReadProtocol.h"
#import "UIColor+ReadingList.h"

@interface REDChartViewController () <REDDateChartDelegate>

#pragma mark - injected
@property (setter=injected:,readonly) id<REDReadDataAccessObject> readDataAccessObject;

#pragma mark - ui
@property (weak, nonatomic) IBOutlet REDDateChart *chart;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation REDChartViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    [self.chart sizeToFitWithPerDayWidth:20.0f];
    [self.chart setGradientStartColor:[UIColor red_redColor]];
    [self.chart setLineColor:[UIColor red_redColor]];
    [self.chart setDelegate:self];
    [self updateData];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - chart delegate
-(void)dateChart:(REDDateChart *)dateChart isNearItem:(REDDateChartItem *)item inPosition:(CGPoint)position {
    NSLog(@"%@",item);
}

#pragma mark - update
-(void)updateData {
    [self.chart clean];
    for (id<REDReadProtocol> read in [self.readDataAccessObject list]) [self.chart addValue:[read pagesValue] forDate:[read date]];
}

#pragma mark - dealloc
-(void)dealloc {
    
}

@end
