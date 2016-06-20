//
//  UITextView+Done.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/19/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "UITextView+Done.h"
#import "UIColor+ReadingList.h"

@implementation UITextView (Done)

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
