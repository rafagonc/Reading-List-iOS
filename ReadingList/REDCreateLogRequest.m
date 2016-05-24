//
//  REDCreateLogRequest.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/6/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDCreateLogRequest.h"

@implementation REDCreateLogRequest

#pragma mark - constructor
-(instancetype)initWithUser:(NSString *)userId logs:(NSArray<id<REDReadProtocol>> *)reads {
    if (self = [super init]) {
        _userId = userId;
        _reads = reads;
    } return self;
}

#pragma mark - request
-(REDHTTPMethod)HTTPMethod {
    return REDHTTPMethodPOST;
}
-(NSDictionary *)HTTPEncode {
    NSMutableDictionary * dict = [@{} mutableCopy];
    dict[@"user_id"] = self.userId;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSMutableArray * log_dicts = [@[] mutableCopy];
    for (id<REDReadProtocol> read in self.reads) {
        if ([read date] != nil && [[read book] name]) {
            NSMutableDictionary *log_dict = [@{} mutableCopy];
            [log_dict setValuesForKeysWithDictionary:@{
                                                       @"date" : [dateFormatter stringFromDate:[read date]],
                                                       @"pages" : [read pagesValue] ? @([read pagesValue]) : @0,
                                                       @"book_name" : [[read book] name],
                                                       }];
            if ([read identifier]) [log_dict setObject:@([read identifier]) forKey:@"id"];
            [log_dicts addObject:log_dict];
        }
    }
    dict[@"logs"] = log_dicts;
    return [dict copy];
}
-(BOOL)isSyncingRequest {
    return YES;
}
-(BOOL)isTransactionRequest {
    return YES;
}
-(NSDictionary *)HTTPHeader {
    return @{};
}
-(NSString *)URL {
    return REDServiceFind(REDServerMetadata_V1, @"log");
}
-(REDSerializer)Serializer {
    return REDJSONSerializer;
}

@end
