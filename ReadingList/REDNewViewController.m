//
//  REDNewViewController.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 2/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDNewViewController.h"

@interface REDNewViewController ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation REDNewViewController

#pragma mark - ui
-(void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"new" ofType:@"txt"];
    NSString * new = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.textView.text = new;
    
}

#pragma mark - actions
-(IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:REDShowedNewFeaturesKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
