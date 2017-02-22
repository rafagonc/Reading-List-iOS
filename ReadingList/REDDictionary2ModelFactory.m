//
//  REDDictionary2ModelFactory.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDDictionary2ModelFactory.h"
#import "REDAbstractClassMethodCallingException.h"

@implementation REDDictionary2ModelFactory

@synthesize input;

#pragma mark - output
-(NSArray *)outputForMany {
    NSMutableArray *transformed = [[NSMutableArray alloc] initWithCapacity:self.input.count];
    for (NSDictionary *dict in self.input) {
        [transformed addObject:[self parse:dict]];
    }
    return [transformed copy];
}
-(id)output {
    return [[self outputForMany] firstObject];
}

#pragma mark - transform
-(id)parse:(NSDictionary *)dict {
    @throw [REDAbstractClassMethodCallingException raise];
}

@end
