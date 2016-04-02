//
//  REDRLMReadDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMReadDataAccessObject.h"
#import "REDRLMRead.h"
#import "REDRLMArrayHelper.h"
#import "REDUserProtocol.h"
#import "NSDate+Escort.h"
#import "REDTransactionManager.h"

@interface REDRLMReadDataAccessObject ()

@property (setter=injected:) id<REDTransactionManager> transactionManager;
@property (setter=injected:) id<REDUserProtocol> user;
@property (setter=injected:) id<REDRLMArrayHelper> rlm_arrayHelper;

@end

@implementation REDRLMReadDataAccessObject

#pragma mark - creating
-(id)create {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    REDRLMRead *read = [[REDRLMRead alloc] init];
    [realm addObject:read];
    [realm commitWriteTransaction];
    return read;
}

#pragma mark - queries
-(id)list {
    return [self.rlm_arrayHelper arrayFromResults:[REDRLMRead allObjects]];
}
-(id)listWithPredicate:(NSPredicate *)predicate {
    return [[self list] filteredArrayUsingPredicate:predicate];
}

#pragma mark - fetching
-(NSArray<id<REDReadProtocol>> *)logsOrderedByDate {
    return (NSArray *)[[self list] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]]];
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
    if ([self.list count] > 0) {
        NSInteger daysTilNow = [[NSDate date] daysAfterDate:[[self list] valueForKeyPath:@"@min.date"]];
        if (daysTilNow == 0) return [self totalPages];
        CGFloat perDay = (CGFloat)[self totalPages]/(CGFloat)daysTilNow;
        return perDay;
    } else {
        return 0.0;
    }
}


@end
