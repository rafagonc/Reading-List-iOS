//
//  UITableView+Autoresize.m
//  SantanderBrasil
//
//  Created by Banco Santander Brasil on 3/17/16.
//  Copyright © 2016 Isban Brasil S/A. All rights reserved.
//

#import "UITableView+Autoresize.h"
#import <objc/runtime.h>

@interface UITableView ()

@property (nonatomic,assign)     CGFloat initialContentSizeHeight;

@end

@implementation UITableView (Autoresize)

#pragma mark - methods
-(void)automaticallyResizeOnKeyboardEvent {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didKeyboardOpen:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willKeyboardClose:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - notifications
-(void)didKeyboardOpen:(NSNotification *)notification {
    if (self.initialContentSizeHeight == 0) self.initialContentSizeHeight = self.contentSize.height;
    CGFloat height = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.contentSize = CGSizeMake(self.contentSize.width, self.initialContentSizeHeight + height);
    [self.keyboardEventDelegate tableViewDidResizeContentSizeOnKeyboardEvent:self];
}
-(void)willKeyboardClose:(NSNotification *)notification {
    self.contentSize = CGSizeMake(self.contentSize.width, self.initialContentSizeHeight);
}

#pragma mark - override
-(void)removeFromSuperview {
    [super removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];

}

#pragma mark - getters and setters
-(void)setInitialContentSizeHeight:(CGFloat)initialContentSizeHeight {
    objc_setAssociatedObject(self, @selector(initialContentSizeHeight), @(initialContentSizeHeight), OBJC_ASSOCIATION_COPY);
}
-(CGFloat)initialContentSizeHeight {
    return [objc_getAssociatedObject(self, @selector(initialContentSizeHeight)) floatValue];
}
-(id<UITableViewKeyboardEventDelegate>)keyboardEventDelegate {
    return objc_getAssociatedObject(self, @selector(keyboardEventDelegate));
}
-(void)setKeyboardEventDelegate:(id<UITableViewKeyboardEventDelegate>)keyboardEventDelegate {
    objc_setAssociatedObject(self, @selector(keyboardEventDelegate), keyboardEventDelegate, OBJC_ASSOCIATION_ASSIGN);
}

@end
