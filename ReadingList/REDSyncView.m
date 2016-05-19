//
//  REDSyncView.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDSyncView.h"
#import "REDUserProtocol.h"

@interface REDSyncView ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIImageView *cloudImageView;

#pragma mark - injected
@property (setter=injected:) id<REDUserProtocol> user;

@end

@implementation REDSyncView

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        [self.cloudImageView setImage:[[UIImage imageNamed:@"cloud-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        [self.cloudImageView setTintColor:[UIColor whiteColor]];
    } return self;
}

#pragma mark - actions
-(IBAction)syncAction:(id)sender {
    [self.delegate syncViewWantsToAuthenticateWithView:self];
}

#pragma mark - layout
-(void)layoutSubviews {
    [super layoutSubviews];
    if ([self.user syncable]) {
        [self.signUpButton setTitle:@"Synced" forState:UIControlStateNormal];
        [self.signUpButton removeTarget:self action:@selector(syncAction:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
        [self.signUpButton addTarget:self action:@selector(syncAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
