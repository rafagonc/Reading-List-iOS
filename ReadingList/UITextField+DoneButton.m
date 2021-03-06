//
//  UITextField+DoneButton.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "UITextField+DoneButton.h"
#import "UIColor+ReadingList.h"

@implementation UITextField (DoneButton)

#pragma mark - methods
-(void)addToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setTintColor:[UIColor red_redColor]];
    [toolbar sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
    [toolbar setItems:@[doneButton]];
    self.inputAccessoryView = toolbar;
}

#pragma mark - actions
-(void)doneAction:(UIBarButtonItem *)button {
    [self resignFirstResponder];
}

@end
