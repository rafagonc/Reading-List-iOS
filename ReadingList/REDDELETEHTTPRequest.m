//
//  REDDELETEHTTPRequest.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDDELETEHTTPRequest.h"
#import "AFNetworking.h"

@implementation REDDELETEHTTPRequest

#pragma mark - DELETE
-(void)callWithRequest:(id<REDRequestProtocol>)request andURL:(NSString *)url andCallback:(REDHTTPRequestProtocolCallback)callback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [request Serializer] == REDXMLSerializer ? [AFXMLParserResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
    [manager DELETE:url parameters:[request HTTPEncode] success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject[@"success"] == nil) {
            callback(responseObject, nil);
            return ;
        }
        if ([responseObject[@"success"] boolValue]) {
            callback(responseObject, nil);
        } else {
            callback(responseObject, [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : responseObject[@"message"]}]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callback(nil, [NSError errorWithDomain:REDErrorDomain code:error.code userInfo :@{ NSLocalizedDescriptionKey : error.localizedDescription , NSLocalizedFailureReasonErrorKey : error.localizedFailureReason}]);
    }];
}

@end
