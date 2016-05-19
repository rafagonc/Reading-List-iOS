//
//  REDSyncingLoadingView.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDSyncingLoadingView.h"
#import "LLARingSpinnerView.h"
#import "UIFont+ReadingList.h"
#import "UIColor+ReadingList.h"

@interface REDSyncingLoadingView ()

@property (nonatomic,strong) LLARingSpinnerView * loading;

@end

@implementation REDSyncingLoadingView

-(void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    self.loading = [[LLARingSpinnerView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 42, self.frame.size.height/2 - 7, 15, 15)];
    self.loading.tintColor = [UIColor red_redColor];
    self.loading.lineWidth = 1.5f;
    [self addSubview:self.loading];
    [self.loading startAnimating];
    
    UILabel * syncingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, [UIScreen mainScreen].bounds.size.width, 20)];
    syncingLabel.font = [UIFont AvenirNextBoldWithSize:12.f];
    syncingLabel.text = @"Syncing";
    syncingLabel.textAlignment = NSTextAlignmentCenter;
    syncingLabel.textColor = [UIColor blackColor];
    [self addSubview:syncingLabel];
}

@end
