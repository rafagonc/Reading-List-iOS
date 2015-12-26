//
//  REDTabBarCustomizer.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDTabBarCustomizer.h"
#import "UIColor+ReadingList.h"

@implementation REDTabBarCustomizer

+(void)customizeTabBar:(UITabBar *)tabBar {
    tabBar.tintColor = [UIColor red_redColor];
    tabBar.translucent = YES;
}

@end
