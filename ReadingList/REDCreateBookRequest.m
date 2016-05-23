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
        if ([[book author] name] && [[book category] name] && [book name]) {
            NSDictionary *book_dict = @{@"name" : [book name], @"author" : [[book author] name], @"category" : [[book category] name], @"pages" : [book pagesValue] ? @([book pagesValue]) : @0, @"pages_read" : [book pagesReadValue] ? @([book pagesReadValue]) : @0 , @"snippet" : [book snippet] ? [book snippet] : @"", @"rate" : [book rate] ? @([book rate]) : @0.0, @"loved" : [book loved] ? @([book loved]) : @NO, @"cover_url" : [book coverURL] ? [book coverURL] : @"" };
            [books addObject:book_dict];
        }
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
    return REDServiceFind(REDServerMetadata_V1, @"book");
}
-(BOOL)isSyncingRequest {
    return YES;
}

@end
