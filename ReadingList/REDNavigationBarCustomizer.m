//
//  SHNavigationBarCustomizer.m
//  Share
//
//  Created by Rafael Gonzalves on 8/28/15.
//  Copyright (c) 2015 Rafael Gonçalves. All rights reserved.
//

#import "REDNavigationBarCustomizer.h"
#import "UIFont+ReadingList.h"
#import "UIColor+ReadingList.h"

@implementation REDNavigationBarCustomizer

#pragma mark - constructor
-(instancetype)initWithNavigationBar:(UINavigationBar *)navigationBar {
    if (self = [super init]) {
        _navigationBar = navigationBar;
    } return self;
}

#pragma mark - customize
-(void)customize {
    _navigationBar.tintColor = [UIColor red_redColor];
    //_navigationBar.clipsToBounds = YES;
    _navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont AvenirNextBoldWithSize:18.0f],  NSForegroundColorAttributeName : [UIColor darkTextColor]};
    _navigationBar.shadowImage = [[UIImage alloc] init];
    _navigationBar.translucent = YES;
}

#pragma mark - factory method
+(void)customizeNavigationBar:(UINavigationBar *)navigationBar {
    [[[REDNavigationBarCustomizer alloc] initWithNavigationBar:navigationBar] customize];
}

@end
