//
//  REDSyncView.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDSyncView.h"
#import "REDUserProtocol.h"
#import "REDAnimationFactory.h"

@interface REDSyncView ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

#pragma mark - properties
@property (nonatomic,strong) id<REDAnimation> animation;

#pragma mark - injected
@property (setter=injected2:) id<REDUserProtocol> user;
@property (setter=injected1:) id<REDAnimationFactory> animationFactory;

@end

@implementation REDSyncView

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startLoading) name:REDStartStatusBarSyncingLoadingViewNotificationKey object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopLoading) name:REDStopStatusBarSyncingLoadingViewNotificationKey object:nil];

    } return self;
}

#pragma mark - actions
-(IBAction)syncAction:(id)sender {
   if (![self.user isSyncable]) [self.delegate syncViewWantsToAuthenticateWithView:self];
}

#pragma mark - layout
-(void)layoutSubviews {
    [super layoutSubviews];
    if ([self.user isSyncable]) {
        [self.signUpButton setTitle:@"Synced" forState:UIControlStateNormal];
        [self.signUpButton removeTarget:self action:@selector(syncAction:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
        [self.signUpButton addTarget:self action:@selector(syncAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - loading
-(void)startLoading {
    [self.signUpButton setTitle:@"Syncing..." forState:UIControlStateNormal];
//    if ([self.animation animating] == NO) {
//        [self.animation stopAnimating];
//        self.animation = [self.animationFactory minimumScaleAnimation];
//        [self.animation startAnimating:self.signUpButton];
//    }
}
-(void)stopLoading {
    [self.signUpButton setTitle:@"Synced" forState:UIControlStateNormal];
    [self.animation stopAnimating];
}

#pragma mark - dealloc
-(void)dealloc {
    [self.animation stopAnimating];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
