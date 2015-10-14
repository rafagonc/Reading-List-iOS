//
//  SHNavigationBarCustomizer.m
//  Share
//
//  Created by Rafael Gonzalves on 8/28/15.
//  Copyright (c) 2015 Rafael Gonçalves. All rights reserved.
//

#import "REDNavigationBarCustomizer.h"
#import "UIFont+ReadingList.h"

@implementation REDNavigationBarCustomizer

#pragma mark - constructor
-(instancetype)initWithNavigationBar:(UINavigationBar *)navigationBar {
    if (self = [super init]) {
        _navigationBar = navigationBar;
    } return self;
}

#pragma mark - customize
-(void)customize {
    _navigationBar.barTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    _navigationBar.tintColor = [UIColor colorWithRed:(239/255.0) green:(81/255.0) blue:(79/255.0) alpha:1];
    _navigationBar.clipsToBounds = YES;
    _navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont AvenirNextBoldWithSize:18.0f],  NSForegroundColorAttributeName : [UIColor darkTextColor]};
    _navigationBar.shadowImage = [[UIImage alloc] init];
    _navigationBar.translucent = NO;
}

#pragma mark - factory method
+(void)customizeNavigationBar:(UINavigationBar *)navigationBar {
    [[[REDNavigationBarCustomizer alloc] initWithNavigationBar:navigationBar] customize];
}

@end
