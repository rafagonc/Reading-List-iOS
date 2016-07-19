//
//  SHNavigationBarCustomizer.h
//  Share
//
//  Created by Rafael Gonzalves on 8/28/15.
//  Copyright (c) 2015 Rafael Gonçalves. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface REDNavigationBarCustomizer : NSObject

#pragma mark - properties
@property (nonatomic,readonly) UINavigationBar *navigationBar;
@property (nonatomic,readonly) UINavigationItem *item;

#pragma mark - constructor
-(instancetype)initWithNavigationBar:(UINavigationBar *)navigationBar;

#pragma mark - customize
-(void)customize;

#pragma mark - factory method
+(void)customizeNavigationBar:(UINavigationBar *)navigationBar;
+(void)customizeNavigationBar:(UINavigationBar *)navigationBar andItem:(UINavigationItem *)item;

@end
