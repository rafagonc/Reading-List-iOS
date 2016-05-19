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
    for (NSDictionary * log_dict in self.input) {
        id<REDReadProtocol> log = [self.logDataAccessObject logWithIdentifier:[log_dict[@"id"] integerValue]];
        if (log) {
            [self.logDataAccessObject updateLog:log WithDict:log_dict];
        } else {
            [self.logDataAccessObject createWithDict:log_dict];
        }
    }
    return logs;
}

@end
