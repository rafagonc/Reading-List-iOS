//
//  REDRequestFeatureImpl.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRequestFeatureImpl.h"
#import "UIColor+ReadingList.h"

@import MessageUI;

@interface REDRequestFeatureImpl ()

<MFMailComposeViewControllerDelegate>

{
    __weak UIViewController *_vc;
}

@end

@implementation REDRequestFeatureImpl

#pragma mark - methods
-(void)request:(UIViewController *)vc {
    _vc = vc;
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    controller.view.tintColor = [UIColor red_redColor];
    [controller setSubject:@"Reading List - Feature Request"];
    [controller setToRecipients:@[@"rafagonc77@yahoo.com.br"]];
    [controller setMessageBody:@"Hi, I'm a user of your app and it would make it more awesome if you add the following to your app: \n\n\n Thanks!" isHTML:NO];
    if (controller) [_vc presentViewController:controller animated:YES completion:nil];
}

#pragma mark - delegate
-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error; {
    if (result == MFMailComposeResultSent) {
         [[[UIAlertView alloc] initWithTitle:@"Thanks" message:@"I'll get back at you as soon as possible!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
