//
//  REDAnimation.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/19/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol REDAnimation <NSObject>

-(void)startAnimating:(UIView *)view;
-(void)stopAnimating;
-(BOOL)animating;

@end
