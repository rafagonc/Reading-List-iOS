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
        NSDictionary *book_dict = @{@"name" : [book name], @"author" : [[book author] name], @"category" : [[book category] name], @"pages" : @([book pagesValue]), @"pages_read" : @([book pagesReadValue]), @"snippet" : [book snippet], @"rate" : @([book rate]), @"loved" : @([book loved])};
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
    return REDServiceFind(REDServerMetadata_V1, @"book");
}
-(BOOL)isSyncingRequest {
    return YES;
}

@end
