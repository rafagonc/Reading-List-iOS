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
    if (self.length == 0) return YES;
    NSScanner *scanner = [NSScanner scannerWithString:self];
    BOOL isNumeric = [scanner scanInteger:NULL] && [scanner isAtEnd];
    return isNumeric;
}

@end
