//
//  REDNewOptionsViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDNewOptionsViewController.h"
#import "UIFont+ReadingList.h"

@interface REDNewOptionsViewController () <UITableViewDelegate, UITableViewDataSource>

#pragma mark - properties
@property (nonatomic,strong) NSArray<NSString *> * options;
@property (nonatomic,copy) REDNewOptionsViewControllerCallback callback;

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation REDNewOptionsViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.size = CGSizeMake(120, 120);
        self.insets = UIEdgeInsetsMake(0, [UIScreen mainScreen].bounds.size.width/2 - self.size.width/2 - 22, [UIScreen mainScreen].bounds.size.height/2 - 105, 0);
        self.animationType = PopoverViewControllerAnimationTypeCrossDissolve;
        self.duration = 0.24f;
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.options = @[@"New Book", @"New Log"];
    
}

#pragma mark - table view
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.options.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    cell.textLabel.text = self.options[indexPath.row];
    cell.textLabel.font = [UIFont AvenirNextBoldWithSize:13.f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.callback) self.callback((REDNewOptions)indexPath.row);
        }];
    });
}

#pragma mark - create
-(void)whatToCreateCallback:(REDNewOptionsViewControllerCallback)callback {
    self.callback = callback;
}


@end
