//
//  REDUserCellStateOpen.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDUserCellStateOpen.h"
#import "REDChartView.h"
#import "REDPageScrollView.h"
#import "REDSyncView.h"
#import "REDPagesInfoView.h"

@interface REDUserCellStateOpen () <REDSyncViewDelegate>

@property (nonatomic,strong) REDSyncView * syncView;
@property (nonatomic,strong) REDChartView * chartView;
@property (nonatomic,strong) REDPagesInfoView * pagesInfoView;

@end

@implementation REDUserCellStateOpen

@synthesize delegate;

-(void)populateScrollView:(REDPageScrollView *)scrollView andCallback:(void (^)(CGSize))callback {
    
    REDChartView * chartView = [[REDChartView alloc] init];
    [chartView setScrollEnabled:NO];
    [chartView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chartTapAction:)]];
    [chartView setTag:REDUserCellChartViewTag];
    [self setChartView:chartView];
    
    REDSyncView * syncView = [[REDSyncView alloc] init];
    [syncView setDelegate:self];
    [syncView setTag:REDUserCellSyncViewTag];
    [self setSyncView:syncView];
    
    REDPagesInfoView * pagesView = [[REDPagesInfoView alloc] init];
    [pagesView setTag:REDUserCellPagesInfoViewTag];
    [self setPagesInfoView:pagesView];
    
    [scrollView setViews:@[chartView, syncView, pagesView]];
    
}
-(void)layoutViews {
    
}
-(BOOL)hidePageControl {
    return NO;
}

#pragma mark - delegates
-(void)syncViewWantsToAuthenticateWithView:(REDSyncView *)syncView {
    [self.delegate userStateWantsToAuthenticate:self];
}

#pragma makr - actions
-(void)chartTapAction:(UITapGestureRecognizer *)tap {
    [self.delegate userStateWantsToOpenChart:self];
}

@end
