//
//  REDRandomQuoteGenerator.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/17/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REDRandomQuoteGenerator : NSObject

#pragma mark - properties
@property (nonatomic,strong) NSArray *quotes;

#pragma makr - quote
-(NSString *)randomQuote;

#pragma mark - factory method
+(NSString *)quote;

@end
