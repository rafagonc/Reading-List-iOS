//
//  REDSignInViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDSignUpViewController.h"
#import <DigitsKit/DigitsKit.h>
#import "UIColor+ReadingList.h"
#import "REDUserUploadImpl.h"
#import "REDUserUpload.h"
#import "REDBookDataAccessObject.h"
#import "REDReadDataAccessObject.h"
#import "UIViewController+Loading.h"
#import "UIViewController+NotificationShow.h"

@interface REDSignUpViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (setter=injected:) id<REDReadDataAccessObject> readDataAccessObject;
@property (setter=injected:) id<REDBookDataAccessObject> bookDataAccessObject;
@property (setter=injected:) id<REDUserProtocol> user;
@property (setter=injected:) id<REDUserUpload> userUpload;
@property (weak, nonatomic) IBOutlet UIImageView *cloudImageView;

@end

@implementation REDSignUpViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    [self.cloudImageView setImage:[[UIImage imageNamed:@"cloud-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [self.cloudImageView setTintColor:[UIColor whiteColor]];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - actions
-(IBAction)signUpAction:(id)sender {
    Digits *digits = [Digits sharedInstance];
    DGTAuthenticationConfiguration *configuration = [[DGTAuthenticationConfiguration alloc] initWithAccountFields:DGTAccountFieldsDefaultOptionMask];
    DGTAppearance *a = [[DGTAppearance alloc] init];;
    a.accentColor = [UIColor red_redColor];
    configuration.appearance = a;
    [digits authenticateWithCompletion:^(DGTSession *session, NSError *error) {
        if (error) {
            [self showNotificationWithType:SHNotificationViewTypeError withMessage:error.localizedDescription];
            return;
        }
        [self startFullLoading];
        [self.userUpload createUser:self.user withBooks:[self.bookDataAccessObject allBooksSorted] andLogs:[self.readDataAccessObject logsOrderedByDate] andUserId:session.userID andAuthToken:session.authToken andAuthTokenSecret:session.authTokenSecret completion:^(BOOL success, NSError *error){
            if (error) {
                [self showNotificationWithType:SHNotificationViewTypeError withMessage:error.localizedDescription];
            } else {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            [self stopFullLoading];
        }];
        
    }];
}
-(IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}

@end
