//
//  REDCloudViewController.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/30/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDCloudViewController.h"
#import "REDSignUpViewController.h"
#import "REDUserProtocol.h"
#import "UIViewController+NotificationShow.h"

@interface REDCloudViewController ()

@property (setter=injected:) id<REDUserProtocol> user;

@end

@implementation REDCloudViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super init]) {
        
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - actions
-(IBAction)activateAction:(id)sender {
    if ([self.user isSyncable]) {
        [self showNotificationWithType:SHNotificationViewTypeSuccess withMessage:@"You are alredy authenticaded!"];
    } else {
        REDSignUpViewController * su = [[REDSignUpViewController alloc] init];
        [self presentViewController:su animated:YES completion:nil];
    }
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}


@end
