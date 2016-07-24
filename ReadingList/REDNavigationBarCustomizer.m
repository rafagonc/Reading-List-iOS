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

@interface REDNavigationBarCustomizer ()

@end

@implementation REDNavigationBarCustomizer

#pragma mark - constructor
-(instancetype)initWithNavigationBar:(UINavigationBar *)navigationBar {
    if (self = [super init]) {
        _navigationBar = navigationBar;
    } return self;
}
-(instancetype)initWithNavigationBar:(UINavigationBar *)navigationBar andItem:(UINavigationItem *)item {
    if (self = [super init]) {
        _navigationBar = navigationBar;
        _item = item;
    } return self;
}

#pragma mark - customize
-(void)customize {
    _navigationBar.tintColor = [UIColor red_redColor];
    _navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont AvenirNextBoldWithSize:18.0f],  NSForegroundColorAttributeName : [UIColor darkTextColor]};
    _navigationBar.shadowImage = [[UIImage alloc] init];
    _navigationBar.translucent = NO;
    _navigationBar.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView * view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    view.frame = CGRectMake(0, 0, 23, 23);
    view.backgroundColor = [UIColor clearColor];
    view.contentMode = UIViewContentModeScaleAspectFit;
    self.item.titleView = view;
    
    UIImageView * logo = [self.navigationBar viewWithTag:10];
    [logo removeFromSuperview];
    
    if (self.item) {
        CGRect myImageS = CGRectMake(0, 0, 23, 23);
        UIImageView *logo = [[UIImageView alloc] initWithFrame:myImageS];
        [logo setTag:10];
        [logo setImage:[UIImage imageNamed:@"logo"]];
        logo.contentMode = UIViewContentModeScaleAspectFit;
        logo.center = CGPointMake(_navigationBar.frame.size.width / 2.0, _navigationBar.frame.size.height / 2.0);
        logo.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self.navigationBar addSubview:logo];
    }
}

#pragma mark - factory method
+(void)customizeNavigationBar:(UINavigationBar *)navigationBar {
    [[[REDNavigationBarCustomizer alloc] initWithNavigationBar:navigationBar] customize];
}
+(void)customizeNavigationBar:(UINavigationBar *)navigationBar andItem:(UINavigationItem *)item {
    [[[REDNavigationBarCustomizer alloc] initWithNavigationBar:navigationBar andItem:item] customize];
}

@end
