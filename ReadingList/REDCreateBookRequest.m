//
//  REDCreateBookRequest.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/5/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDCreateBookRequest.h"

@implementation REDCreateBookRequest

#pragma mark - constructor
-(instancetype)initWithUserId:(NSString *)userId books:(NSArray <id<REDBookProtocol>> *)books {
    if (self = [super init]) {
        _userId = userId;
        _books = books  ;
    } return self;
}

#pragma mark - request
-(REDHTTPMethod)HTTPMethod {
    return REDHTTPMethodPOST;
}
-(NSDictionary *)HTTPEncode {
    NSMutableDictionary *dict =  [@{  @"user_id" : self.userId } mutableCopy];
    NSMutableArray * books = [@[] mutableCopy];
    for (id<REDBookProtocol> book in self.books) {
        NSDictionary *book_dict = @{@"book_name" : [book name], @"author_name" : [[book author] name], @"category_name" : [[book category] name], @"pages" : @([book pagesValue]), @"pages_read" : @([book pagesReadValue]), @"snippet" : [book snippet]};
        [books addObject:book_dict];
    }
    [dict setObject:books forKey:@"books"];
    return dict;
}
-(NSDictionary *)HTTPHeader {
    return @{};
}
-(REDSerializer)Serializer {
    return REDJSONSerializer;
}
-(NSString *)URL {
    return nil;
}
-(BOOL)isSyncingRequest {
    return YES;
}

@end
