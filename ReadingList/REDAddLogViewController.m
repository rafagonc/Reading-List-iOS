//
//  REDAddLogViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/26/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDAddLogViewController.h"
#import "UIStaticTableView.h"
#import "REDBookDataAccessObject.h"

@interface REDAddLogViewController ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIStaticTableView *tableView;

#pragma mark - properties

#pragma mark - injected

@end

@implementation REDAddLogViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}

@end
