//
//  REDNameViewController.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/30/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDNameViewController.h"
#import "UITextField+DoneButton.h"

@interface REDNameViewController () {
    CGPoint initialPoint;
}

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerVerticalContainerViewConstraint;

@end

@implementation REDNameViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super init]) {
        
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    initialPoint = self.containerView.frame.origin;
    
    [self.nameTextField addToolbar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillOpen:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillClose:) name:UIKeyboardWillHideNotification object:nil];

}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - keyboard
-(void)keyboardWillOpen:(NSNotification *)notification {
    self.centerVerticalContainerViewConstraint.constant = - 100;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}
-(void)keyboardWillClose:(NSNotification *)notification {
    self.centerVerticalContainerViewConstraint.constant = 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}

@end
