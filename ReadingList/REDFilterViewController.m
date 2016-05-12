//
//  REDFilterViewController.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/12/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDFilterViewController.h"

@interface REDFilterViewController ()

#pragma mark - constructor
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation REDFilterViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.size = CGSizeMake([UIScreen mainScreen].bounds.size.width * .8f, 300);
        self.cornerRadius = 12;
        
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}


@end
