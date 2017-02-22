//
//  REDRLMResultsToNSArray.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/4/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMResultsToNSArray.h"

@implementation REDRLMResultsToNSArray

-(NSArray *)arrayFromResults:(RLMResults *)results {
    NSMutableArray *arr = [@[]mutableCopy];
    for (id obj in results) {
        [arr addObject:obj];
    }
    return [arr copy];
}

@end
