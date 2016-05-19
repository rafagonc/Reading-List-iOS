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
@property (nonatomic,strong) UILabel * syncingLabel;

@end

@implementation REDSyncingLoadingView

-(void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    self.loading = [[LLARingSpinnerView alloc] initWithFrame:CGRectZero];
    self.loading.tintColor = [UIColor red_redColor];
    self.loading.lineWidth = 1.5f;
    [self addSubview:self.loading];
    [self.loading startAnimating];
    
    UILabel * syncingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    syncingLabel.font = [UIFont AvenirNextBoldWithSize:12.f];
    syncingLabel.text = @"Syncing";
    syncingLabel.textAlignment = NSTextAlignmentCenter;
    syncingLabel.textColor = [UIColor blackColor];
    [self addSubview:syncingLabel];
    [self setSyncingLabel:syncingLabel];
    
}
-(void)layoutSubviews {
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    self.loading.frame = CGRectMake(self.frame.size.width/2 - 35, self.frame.size.height/2 - 7, 15, 15);
    self.syncingLabel.frame = CGRectMake(self.frame.size.width/2 - 43, 1, 100, 20);
}

@end
