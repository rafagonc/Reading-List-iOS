//
//  REDBookDetailViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookDetailViewController.h"

@interface REDBookDetailViewController ()

@end

@implementation REDBookDetailViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Details";
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


@end
