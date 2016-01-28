
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

@interface REDUserScrollView ()

#pragma mark - ui
@property (nonatomic,weak) REDUserView *userView;
@property (nonatomic,weak) REDPagesInfoView *pagesView;

#pragma mark - views
@property (nonatomic,strong) NSMutableArray * scrollingSubviews;

@end

@implementation REDUserScrollView

#pragma mark - overrides
-(void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.scrollingSubviews = [@[] mutableCopy];
    
    REDUserView *userView = [[REDUserView alloc] init];
    [self.scrollingSubviews addObject:userView];
    [self addSubview:userView];
    self.userView = userView;
    
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
