//
//  UITableView+Autoresize.h
//  SantanderBrasil
//
//  Created by Banco Santander Brasil on 3/17/16.
//  Copyright © 2016 Isban Brasil S/A. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UITableViewKeyboardEventDelegate <NSObject>

-(void)tableViewDidResizeContentSizeOnKeyboardEvent:(UITableView *)tableView;

@end

@interface UITableView (Autoresize)

#pragma mark - properties
@property (nonatomic, weak) id<UITableViewKeyboardEventDelegate> keyboardEventDelegate;

#pragma mark - methods
-(void)automaticallyResizeOnKeyboardEvent;

@end
