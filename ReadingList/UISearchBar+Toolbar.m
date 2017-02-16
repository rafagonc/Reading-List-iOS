//
//  UISearchBar+Toolbar.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/17/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "UISearchBar+Toolbar.h"
#import "UIColor+ReadingList.h"
#import <objc/runtime.h>

@interface UISearchBar ()

@property UISearchBarDoneCallback callback;

@end

@implementation UISearchBar (Toolbar)

#pragma mark - methods
-(void)addToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setTintColor:[UIColor red_redColor]];
    [toolbar sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
    [toolbar setItems:@[doneButton]];
    self.inputAccessoryView = toolbar;
}
-(void)addToolbarWithCallback:(UISearchBarDoneCallback)callback {
    [self addToolbar];
    self.callback = callback;
}

#pragma mark - actions
-(void)doneAction:(UIBarButtonItem *)button {
    [self resignFirstResponder];
    if (self.callback) self.callback();
}

#pragma mark - setters and gettes
-(void)setCallback:(UISearchBarDoneCallback)callback {
    objc_setAssociatedObject(self, @selector(callback), callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(UISearchBarDoneCallback)callback {
    return objc_getAssociatedObject(self, @selector(callback));
}

@end
