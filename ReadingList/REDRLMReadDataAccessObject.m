//
//  REDRLMReadDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMReadDataAccessObject.h"
#import "REDRLMRead.h"

@implementation REDRLMReadDataAccessObject

#pragma mark - creating
-(id)create {
    return [[REDRLMRead alloc] init];
}

#pragma mark - queries
-(NSArray *)list {
    return (NSArray *)[REDRLMRead allObjects];
}
-(NSArray *)listWithPredicate:(NSPredicate *)predicate {
    return (NSArray *)[REDRLMRead objectsWithPredicate:predicate];
}

#pragma mark - fetching
-(NSArray<id<REDReadProtocol>> *)logsOrderedByDate {
    return [[self list] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]]];
}
-(NSUInteger)totalPages {
    NSUInteger totalPages = 0;
    NSArray <id<REDReadProtocol>> * reads = [self list];
    for (id<REDReadProtocol> read in reads) {
        totalPages += [read pagesValue];
    }
    return totalPages;
}
-(CGFloat)perDay {
//    if ([self.user firstReadCreated] == nil) [self.user setFirstReadCreated:[NSDate date]];
//    NSInteger daysTilNow = [[NSDate date] daysAfterDate:[self.user firstReadCreated]];
//    if (daysTilNow == 0) return [self totalPages];
//    CGFloat perDay = (CGFloat)[self totalPages]/(CGFloat)daysTilNow;
//    return perDay;
    return 0.0;
}



@end
