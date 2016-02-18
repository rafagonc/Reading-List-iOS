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
#import "NSDate+Escort.h"
#import "REDChartCallout.h"

@interface REDChartViewController () <REDDateChartDelegate>

#pragma mark - injected
@property (setter=injected:,readonly) id<REDReadDataAccessObject> readDataAccessObject;

#pragma mark - ui
@property (weak, nonatomic) REDChartCallout *callout;
@property (weak, nonatomic) IBOutlet REDDateChart *chart;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

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
    [self.chart sizeToFitWithPerDayWidth:30];
    [self.chart setGradientStartColor:[[UIColor red_redColor] colorWithAlphaComponent:0.4]];
    [self.chart setGradientEndColor:[[UIColor red_redColor] colorWithAlphaComponent:0.15]];
    [self.chart setLineColor:[UIColor red_redColor]];
    [self.chart setDelegate:self];
    [self updateData];
    
    REDChartCallout *callout = [[REDChartCallout alloc] init];
    callout.hidden = YES;
    [self.view addSubview:callout];
    [self setCallout:callout];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateData];
}

#pragma mark - chart delegate
-(void)dateChart:(REDDateChart *)dateChart isNearItem:(REDDateChartItem *)item inPosition:(CGPoint)position {
    self.callout.hidden = item == nil;
    self.callout.frame = CGRectMake(position.x, position.y + 140 , self.callout.frame.size.width, self.callout.frame.size.height);
    [self.callout setItem:item];
}

#pragma mark - update
-(void)updateData {
    [self.chart clean];
    for (id<REDReadProtocol> read in [self.readDataAccessObject list]) [self.chart addValue:[read pagesValue] forDate:[read date]];
    NSPredicate *todayDatePredicate = [NSPredicate predicateWithFormat:@"date = %@", [[NSDate date] dateAtStartOfDay]];
    if ([[self.readDataAccessObject list] filteredArrayUsingPredicate:todayDatePredicate].count == 0) {
        [self.chart addValue:0.0 forDate:[NSDate date]];
    }
    [self.contentView setFrame:(CGRect){self.contentView.frame.,[self.chart sizeForChart]}];
    [self.scrollView setContentSize:[self.chart sizeForChart]];
}

#pragma mark - dealloc
-(void)dealloc {
    
}

@end
