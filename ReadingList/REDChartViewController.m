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
#import "REDLogSummaryViewController.h"

@interface REDChartViewController () <REDDateChartDelegate>

#pragma mark - injected
@property (setter=injected:) id<REDReadDataAccessObject> readDataAccessObject;

#pragma mark - ui
@property (strong, nonatomic) REDDateChart *chart;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *emptyLabel;

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
    
    [Localytics tagEvent:@"Chart View"];
    
    
    self.chart = [[REDDateChart alloc] init];
    [self.chart sizeToFitWithPerDayWidth:30];
    [self.chart setGradientStartColor:[[UIColor red_redColor] colorWithAlphaComponent:0.4]];
    [self.chart setGradientEndColor:[[UIColor red_redColor] colorWithAlphaComponent:0.15]];
    [self.chart setLineColor:[UIColor red_redColor]];
    [self.chart setDelegate:self];
    [self.scrollView addSubview:self.chart];
    [self updateData];
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width - self.scrollView.frame.size.width, 0)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];

}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self updateData];
}
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.chart.frame = CGRectMake(0, 70 , [self.chart sizeForChart].width, self.scrollView.frame.size.height - 70);
}

#pragma mark - orientation
-(void)orientationChanged:(NSNotification *)notification {
    UIDeviceOrientation currentDeviceOrientation =  [[UIDevice currentDevice] orientation];
    if (UIDeviceOrientationIsPortrait(currentDeviceOrientation)) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - chart delegate
-(void)dateChart:(REDDateChart *)dateChart isNearItem:(REDDateChartItem *)item inPosition:(CGPoint)position {
    NSArray <id<REDReadProtocol>> * readsForDay = [self.readDataAccessObject listWithPredicate:[NSPredicate predicateWithFormat:@"date > %@ AND date < %@", [[item date] dateAtStartOfDay], [[item date] dateAtEndOfDay]]];
    REDLogSummaryViewController * summary = [[REDLogSummaryViewController alloc] initWithLogs:readsForDay andDate:item.date];
    [self.navigationController pushViewController:summary animated:YES];
}

#pragma mark - update
-(void)updateData {
    [self.chart clean];
    for (id<REDReadProtocol> read in [self.readDataAccessObject list]) {
     [self.chart addValue:[read pagesValue] forDate:[read date]];   
    }
    [self.chart addValue:0.0 forDate:[NSDate date]];
    [self.scrollView setContentSize:CGSizeMake([self.chart sizeForChart].width + 120, [self.chart sizeForChart].height)];
    self.emptyLabel.hidden = [self.readDataAccessObject list].count > 0;
    self.scrollView.hidden = [self.readDataAccessObject list].count == 0;
}

#pragma mark - dealloc
-(void)dealloc {
    
}

@end
