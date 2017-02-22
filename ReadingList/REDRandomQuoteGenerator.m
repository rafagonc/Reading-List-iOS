//
//  REDRandomQuoteGenerator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/17/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDRandomQuoteGenerator.h"

@implementation REDRandomQuoteGenerator

#pragma mark - constructor
-(instancetype)init {
    if (self = [super init]) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"books" ofType:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.quotes = json[@"quotes"];
    } return self;
}

#pragma makr - quote
-(NSString *)randomQuote {
    NSUInteger randomNumber = arc4random() % self.quotes.count;
    return [self.quotes objectAtIndex:randomNumber];
}

#pragma mark - factory method
+(NSString *)quote {
    return [[[self alloc] init] randomQuote];
}

@end
