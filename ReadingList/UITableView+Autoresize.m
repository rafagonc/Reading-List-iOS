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
@property (nonatomic,assign)     BOOL isKeyboardOpen;
@property (nonatomic,assign)     CGFloat lastBoundsSizeHeight;


@end

@implementation UITableView (Autoresize)

#pragma mark - methods
-(void)automaticallyResizeOnKeyboardEvent {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didKeyboardOpen:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willKeyboardClose:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)unregisterResizingOnKeyboardEvent {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - notifications
-(void)didKeyboardOpen:(NSNotification *)notification {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    CGRect kbFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect kbIntersectFrame = [window convertRect:CGRectIntersection(window.frame, kbFrame) toView:self];
    kbIntersectFrame = CGRectIntersection(self.bounds, kbIntersectFrame);
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbIntersectFrame.size.height, 0.0);
    self.contentInset = contentInsets;
    self.scrollIndicatorInsets = contentInsets;
}
-(void)willKeyboardClose:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    self.contentInset = contentInsets;
    self.scrollIndicatorInsets = contentInsets;
}

#pragma mark - getters and setters
-(void)setInitialContentSizeHeight:(CGFloat)initialContentSizeHeight {
    objc_setAssociatedObject(self, @selector(initialContentSizeHeight), @(initialContentSizeHeight), OBJC_ASSOCIATION_COPY);
}
-(CGFloat)initialContentSizeHeight {
    NSValue * value = objc_getAssociatedObject(self, @selector(initialContentSizeHeight));
    CGFloat unwrappedValue;
    [value getValue:&unwrappedValue];
    return unwrappedValue;
}
-(void)setLastBoundsSizeHeight:(CGFloat)lastBoundsSizeHeight {
    objc_setAssociatedObject(self, @selector(lastBoundsSizeHeight), @(lastBoundsSizeHeight), OBJC_ASSOCIATION_COPY);
}
-(CGFloat)lastBoundsSizeHeight {
    NSValue * value = objc_getAssociatedObject(self, @selector(lastBoundsSizeHeight));
    CGFloat unwrappedValue;
    [value getValue:&unwrappedValue];
    return unwrappedValue;
}
-(void)setIsKeyboardOpen:(BOOL)isKeyboardOpen {
    objc_setAssociatedObject(self, @selector(isKeyboardOpen), @(isKeyboardOpen), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(BOOL)isKeyboardOpen {
    return [objc_getAssociatedObject(self, @selector(isKeyboardOpen)) boolValue];
}
-(id<UITableViewKeyboardEventDelegate>)keyboardEventDelegate {
    return objc_getAssociatedObject(self, @selector(keyboardEventDelegate));
}
-(void)setKeyboardEventDelegate:(id<UITableViewKeyboardEventDelegate>)keyboardEventDelegate {
    objc_setAssociatedObject(self, @selector(keyboardEventDelegate), keyboardEventDelegate, OBJC_ASSOCIATION_ASSIGN);
}

@end
