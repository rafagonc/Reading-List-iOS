//
//  REDAllSetViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDAllSetViewController.h"

@interface REDAllSetViewController ()

@end

@implementation REDAllSetViewController


#pragma mark - constructor
-(instancetype)initWithDelegate:(id<REDAllSetViewControllerDelegate>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
    } return self;
}

#pragma mark - actions
-(IBAction)continueButton:(id)sender {
    [self.delegate controllerDidFinishTutorial:self];
}

-(BOOL)process:(REDTutorialViewController *)tutorial error:(NSError *__autoreleasing *)error {
    return YES;
}

@end
