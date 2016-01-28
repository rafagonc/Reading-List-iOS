//
//  REDReadDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDReadDataAccessObjectImpl.h"
#import "REDUserProtocol.h"
#import "NSDate+Escort.h"

@interface REDReadDataAccessObjectImpl ()

@property (setter=injected:,readonly) id<REDUserProtocol> user;

@end

@implementation REDReadDataAccessObjectImpl

#pragma mark - insertion
-(id)create {
    if ([self list].count == 0) {
        [self.user setFirstReadCreated:[NSDate date]];
    }
    return [super create];
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
    if ([self.user firstReadCreated] == nil) [self.user setFirstReadCreated:[NSDate date]];
    NSInteger daysTilNow = [[NSDate date] daysAfterDate:[self.user firstReadCreated]];
    if (daysTilNow == 0) return [self totalPages];
    CGFloat perDay = (CGFloat)[self totalPages]/(CGFloat)daysTilNow;
    return perDay;
}

#pragma mark - overrides
-(NSString *)entityName {
    return @"REDRead";
}

@end
