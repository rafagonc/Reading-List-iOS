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
#import "REDBookDataAccessObject.h"
#import "NSDate+Additions.h"

@interface REDRLMReadDataAccessObject ()

@property (setter=injected1:) id<REDTransactionManager> transactionManager;
@property (setter=injected2:) id<REDUserProtocol> user;
@property (setter=injected3:) id<REDRLMArrayHelper> rlm_arrayHelper;
@property (setter=injected4:) id<REDBookDataAccessObject> bookDataAccessObject;

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
-(id<REDReadProtocol>)createWithDict:(NSDictionary *)dict {
    id<REDBookProtocol> book = [[self.bookDataAccessObject searchBooksWithString:dict[@"book_ref"][@"name"]] firstObject];
    if (book) {
        id<REDReadProtocol> log = [self create];
        [self updateLog:log WithDict:dict];
        return log;
    }
    return nil;
}
-(void)updateLog:(id<REDReadProtocol>)log WithDict:(NSDictionary *)dict {
    NSDate * date = [NSDate sam_dateFromISO8601String:[dict objectForKey:@"date"]];
    id<REDBookProtocol> book = [[self.bookDataAccessObject searchBooksWithIdentifier:[dict[@"book_ref"][@"id"] integerValue]] firstObject];
    [self.transactionManager begin];
    [log setPagesValue:[dict[@"pages"] integerValue]];
    [log setBook:book];
    [log setDate:date];
    [log setIdentifier:[dict[@"id"] integerValue]];
    [self.transactionManager commit];
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
-(id<REDReadProtocol>)logWithDate:(NSDate *)date {
    for (id<REDReadProtocol> read in [self list]) {
        if ([[read date] isEqualToDate:date]) {
            return read;
        }
    }
    return nil;
}
-(id<REDReadProtocol>)logWithIdentifier:(NSUInteger)identifier {
    return [[self listWithPredicate:[NSPredicate predicateWithFormat:@"identifier = %lu", identifier]] firstObject];
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
