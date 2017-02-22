//
//  REDTutorialCreator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/4/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDTutorialCreator.h"
#import "REDTutorialViewController.h"

@implementation REDTutorialCreator

+(void)showTutorialOn:(UIViewController *)vc {
    BOOL showed = [[[NSUserDefaults standardUserDefaults] objectForKey:REDTutorialAlreadyShowedKey] boolValue];
    if (showed == NO) {
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:REDTutorialAlreadyShowedKey];
        REDTutorialViewController * t = [[REDTutorialViewController alloc] init];
        [vc presentViewController:t animated:YES completion:nil];
    }
}

@end
