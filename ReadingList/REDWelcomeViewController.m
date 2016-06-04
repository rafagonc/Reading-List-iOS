//
//  REDWelcomeViewController.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/30/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDWelcomeViewController.h"

@interface REDWelcomeViewController ()

@end

@implementation REDWelcomeViewController

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

#pragma mark - chain 
-(BOOL)process:(REDTutorialViewController *)tutorial error:(NSError *__autoreleasing *)error {
    return YES;
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}


@end
