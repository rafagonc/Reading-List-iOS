//
//  REDListLogsFactory.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/19/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDListLogsFactory.h"
#import "REDReadDataAccessObject.h"
#import "REDReadProtocol.h"
#import "NSDate+Additions.h"

@interface REDListLogsFactory ()

@property (setter=injected:) id<REDReadDataAccessObject> logDataAccessObject;

@end

@implementation REDListLogsFactory

-(NSArray *)outputForMany {
    NSMutableArray *logs = [@[] mutableCopy];
    
    if (self.input.count == 0) return logs;
    
    //creatte and upatte
    for (NSDictionary * log_dict in self.input) {
        id<REDReadProtocol> log = [self.logDataAccessObject logWithUUID:log_dict[@"uuid"]];
        if (log) {
            [self.logDataAccessObject updateLog:log WithDict:log_dict];
        } else {
            if ([[log_dict objectForKey:@"book_ref"] isEqual:[NSNull null]] == NO) {
                [self.logDataAccessObject createWithDict:log_dict];
            }
        }
    }
    
    for (id<REDReadProtocol> log in [self.logDataAccessObject logsOrderedByDate]) {
        NSDictionary *log_dict = [[self.input filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"id = %lu", [log identifier]]] firstObject];
        if (!log_dict) {
            [self.logDataAccessObject remove:log];
        }
        
    }
    
    return logs;
}

@end
