//
//  REDUserCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/16/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDUserCell.h"
#import "REDAnimation.h"
#import "REDAnimationFactory.h"
#import "UITextField+DoneButton.h"
#import "REDTransactionManager.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDUpdateUserRequest.h"
#import "REDUserCellState.h"
#import "REDUserCellStateOpen.h"
#import "REDUserCellStateClosed.h"
#import "REDPageScrollView.h"
#import "REDUserCellStateDelegate.h"

@interface REDUserCell ()  <UITextFieldDelegate, REDUserCellStateDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cloudImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet REDPageScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

#pragma mark - properties
@property (nonatomic,strong) id<REDAnimation> animation;
@property (nonatomic,assign) BOOL open;
@property (nonatomic,strong) id<REDUserCellState> state;

#pragma mark - injected
@property (setter=injected1:) id<REDAnimationFactory> animationFactory;
@property (setter=injected2:) id<REDTransactionManager> transactionManager;
@property (setter=injected3:) id<REDServiceDispatcherProtocol> serviceDispatcher;
@end

@implementation REDUserCell

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startLoading) name:REDStartStatusBarSyncingLoadingViewNotificationKey object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopLoading) name:REDStopStatusBarSyncingLoadingViewNotificationKey object:nil];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } return self;
}

#pragma mark - setter
-(void)setUser:(id<REDUserProtocol>)user {
    _user = user;
    self.userImageView.image = [user photo];
    self.nameTextField.text = [user name];
    self.nameTextField.delegate =self;
    self.scrollView.pageControl = self.pageControl;
    [self.nameTextField addToolbar];
    self.open = NO;

}
-(void)setOpen:(BOOL)open {
    _open = open;
    self.state = open ? [[REDUserCellStateOpen alloc] init] : [[REDUserCellStateClosed alloc] init];
    [self.state setDelegate:self];
    [self.delegate userCellWantsToOpen:self];
    [self.pageControl setHidden:[self.state hidePageControl]];
    [self.arrowImageView setImage:self.open ? [UIImage imageNamed:@"up_arrow"] : [UIImage imageNamed:@"down_arrow"]];
    
    if (!open) {
        [self.bottomView setAlpha:0];
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.state populateScrollView:self.scrollView andCallback:^(CGSize contentSize) {
                self.scrollView.contentSize = contentSize;
            }];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            [self.bottomView setAlpha:1];
        }];
        self.scrollView.alpha = 1;
        [self.state populateScrollView:self.scrollView andCallback:^(CGSize contentSize) {
            self.scrollView.contentSize = contentSize;
        }];
    }
}

#pragma mark - loading
-(void)startLoading {
    if ([self.animation animating] == NO) {
        [self.animation stopAnimating];
        self.animation = [self.animationFactory minimumScaleAnimation];
        [self.animation startAnimating:self.cloudImageView];
    }
}
-(void)stopLoading {
    [self setNeedsLayout];
    [self.animation stopAnimating];
}

#pragma mark - text field delegate
-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.transactionManager begin];
    [self.user setName:textField.text];
    [self.transactionManager commit];
    if ([self.user isSyncable]) {
        REDUpdateUserRequest * updateUserRequest = [[REDUpdateUserRequest alloc] initWithUser:self.user];
        [self.serviceDispatcher callWithRequest:updateUserRequest withTarget:self andSelector:@selector(response:)];
    }
}
-(void)response:(NSNotification *)notif {
    
}

#pragma mark - height
-(CGFloat)height {
    if (self.open) {
        return 250;
    } else{
        return 90;
    }
}

#pragma mark - delegate
-(void)userStateWantsToOpenChart:(id<REDUserCellState>)cell {
    [self.delegate userCellWantsToOpenChart:self];
}
-(void)userStateWantsToAuthenticate:(id<REDUserCellState>)cell {
    if ([self.user isSyncable] == NO) {
        [self.delegate userCellWantsToAuthenticate:self];
    }
}

#pragma mark - action
-(IBAction)openAction:(id)sender {
    self.open = !self.open;
}
-(IBAction)changeImageAction:(id)sender {
    [self.delegate userCellWantsToChangePhoto:self];
}

#pragma mark - dealloc
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
