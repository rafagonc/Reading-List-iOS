//
//  DYPShareImpl.m
//  Picfind
//
//  Created by Rafael Gonzalves on 3/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

@import Social;
#import "REDFacebookShareImpl.h"

@implementation REDFacebookShareImpl

-(void)share:(UIImage *)image with:(NSString *)text from:(UIViewController *)vc {
    SLComposeViewController *compose = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [compose addImage:image];
    [compose setTitle:text];
    [vc presentViewController:compose animated:YES completion:nil];
}

@end
