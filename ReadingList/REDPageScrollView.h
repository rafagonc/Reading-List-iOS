//
//  REDPageScrollView.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface REDPageScrollView : UIScrollView

@property (nonatomic,strong) NSArray <UIView *> * views;
@property (nonatomic,weak) UIPageControl * pageControl;

@end
