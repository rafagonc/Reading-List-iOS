//
//  DYPTwitterShareImpl.m
//  Picfind
//
//  Created by Rafael Gonzalves on 3/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDTwitterShareImpl.h"

@import Social;

@implementation REDTwitterShareImpl

-(void)share:(UIImage *)image with:(NSString *)text from:(UIViewController *)vc {
    SLComposeViewController *compose = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [compose addImage:image];
    [compose setInitialText:text];
    [vc presentViewController:compose animated:YES completion:nil];
}

@end
