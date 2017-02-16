
//
//  REDUserScrollView.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/27/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDUserScrollView.h"
#import "REDUserView.h"
#import "REDPagesInfoView.h"
#import "REDSyncView.h"

@interface REDUserScrollView () <UIScrollViewDelegate>

#pragma mark - ui
@property (nonatomic,weak) REDUserView *userView;
@property (nonatomic,weak) REDPagesInfoView *pagesView;
@property (nonatomic,weak) REDSyncView *syncView;

#pragma mark - views
@property (nonatomic,strong) NSMutableArray * scrollingSubviews;

@end

@implementation REDUserScrollView

#pragma mark - overrides
-(void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.scrollingSubviews = [@[] mutableCopy];
    
    REDUserView *userView = [[REDUserView alloc] init];
    [self.scrollingSubviews addObject:userView];
    [self addSubview:userView];
    self.userView = userView;
    
    REDSyncView *syncView = [[REDSyncView alloc] init];
    [self.scrollingSubviews addObject:syncView];
    [self addSubview:syncView];
    [self setSyncView:syncView];
    
    REDPagesInfoView *pagesInfoView = [[REDPagesInfoView alloc] init];
    [self.scrollingSubviews addObject:pagesInfoView];
    [self addSubview:pagesInfoView];
    self.pagesView = pagesInfoView;
}

#pragma mark - setters
-(void)setUser:(id<REDUserProtocol>)user {
    self.userView.user = user;
}
-(void)setUserViewDelegate:(id<REDUserViewDelegate>)userViewDelegate {
    self.userView.delegate = userViewDelegate;
}
-(void)setSyncViewDelegate:(id<REDSyncViewDelegate>)syncViewDelegate {
    self.syncView.delegate = syncViewDelegate;
}
-(void)setPageControl:(UIPageControl *)pageControl {
    _pageControl = pageControl;
    [pageControl setNumberOfPages:3];
}

#pragma mark - delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x/scrollView.frame.size.width);
}

#pragma mark - methods
-(void)updateData {
    [self.pagesView updateData];
    self.userView.user = self.userView.user;
}

#pragma mark - layout
-(void)layoutSubviews {
    [super layoutSubviews];
    [self.scrollingSubviews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = self.scrollingSubviews[idx];
        view.frame = CGRectMake(self.frame.size.width * idx, 0, self.frame.size.width, self.frame.size.height);
    }];
    self.contentSize = CGSizeMake(self.frame.size.width * self.scrollingSubviews.count, self.frame.size.height);
}


@end
