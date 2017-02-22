//
//  REDTopRatedRequest.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/16/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDTopRatedRequest.h"

@implementation REDTopRatedRequest

-(NSString *)URL {
    REDServiceFind(REDServerMetadata_V1, @"book/top");
    NSLog(@"%@",REDServiceFind(REDServerMetadata_V1, @"book/top"));
    return @"https://reading-list-prod.herokuapp.com/book/top";
}
-(REDHTTPMethod)HTTPMethod {
    return REDHTTPMethodGET;
}
-(NSDictionary *)HTTPEncode {
    return @{};
}
-(NSDictionary *)HTTPHeader {
    return @{@"Accept" : @"application/json",
             @"Content-Type" : @"application/json"};
}
-(REDSerializer)Serializer {
    return REDJSONSerializer;
}
-(BOOL)isSyncingRequest {
    return NO;
}
-(BOOL)isTransactionRequest {
    return NO;
}

@end
