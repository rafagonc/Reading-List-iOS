//
//  DYPMailShareImpl.m
//  Picfind
//
//  Created by Rafael Gonzalves on 3/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDMailShareImpl.h"
@import MessageUI;


@interface REDMailShareImpl () <MFMailComposeViewControllerDelegate>

@property (nonatomic,weak) UIViewController *vc;
@property (nonatomic,strong) MFMailComposeViewController *mail_vc;

@end

@implementation REDMailShareImpl

-(void)share:(UIImage *)image with:(NSString *)text from:(UIViewController *)vc {
    MFMailComposeViewController *emailShareController = [[MFMailComposeViewController alloc] init];
    emailShareController.mailComposeDelegate = self;
    [emailShareController setMessageBody:text isHTML:NO];
    [emailShareController addAttachmentData:UIImageJPEGRepresentation(image, 1) mimeType:@"image/jpeg" fileName:@"image.jpeg"];
    if (emailShareController) [vc presentViewController:emailShareController animated:YES completion:nil];
    [self setMail_vc:emailShareController];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}


@end
