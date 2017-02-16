//
//  REDPUTHTTPRequest.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDPUTHTTPRequest.h"
#import "AFNetworking.h"

@implementation REDPUTHTTPRequest

#pragma mark - PUT
-(void)callWithRequest:(id<REDRequestProtocol>)request andURL:(NSString *)url andCallback:(REDHTTPRequestProtocolCallback)callback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [request Serializer] == REDXMLSerializer ? [AFXMLParserResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
    [manager PUT:url parameters:[request HTTPEncode] success:^(NSURLSessionDataTask *task, id responseObject) {
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
        callback(nil, [NSError errorWithDomain:REDErrorDomain code:error.code userInfo :@{ NSLocalizedDescriptionKey : error.localizedDescription}]);
    }];
}

@end
