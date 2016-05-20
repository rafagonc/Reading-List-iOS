
//
//  REDAnimationFactoryImpl.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/19/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDAnimationFactoryImpl.h"
#import "REDMinimumScaleAnimation.h"

@implementation REDAnimationFactoryImpl

-(id<REDAnimation>)minimumScaleAnimation {
    return [[REDMinimumScaleAnimation alloc] init];
}

@end
