//
//  NSString+Digits.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/15/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "NSString+Digits.h"

@implementation NSString (Digits)

#pragma mark - digits
-(BOOL)onlyDigits {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self MATCHES [0-9]+"];
    return [predicate evaluateWithObject:predicate];
}

@end
