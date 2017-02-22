//
//  UIColor+Components.m
//  LineChart
//
//  Created by Rafael Gonzalves on 2/17/16.
//  Copyright © 2016 Banco Santander Brasil. All rights reserved.
//

#import "UIColor+Components.h"

@implementation UIColor (Components)

-(CGFloat)red {
    const CGFloat * components = CGColorGetComponents(self.CGColor);
    return components[0];
}
-(CGFloat)green {
    const CGFloat * components = CGColorGetComponents(self.CGColor);
    return components[1];
}
-(CGFloat)blue {
    const CGFloat * components = CGColorGetComponents(self.CGColor);
    return components[2];
}
-(CGFloat)alpha {
    const CGFloat * components = CGColorGetComponents(self.CGColor);
    return components[3];
}

@end
