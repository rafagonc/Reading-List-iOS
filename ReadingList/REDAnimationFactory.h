//
//  REDAnimationFactory.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/19/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDAnimation.h"

@protocol REDAnimationFactory <NSObject>

-(id<REDAnimation>)minimumScaleAnimation;

@end
