//
//  REDPOSTHTTPRequest.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDPOSTHTTPRequest.h"
#import "AFNetworking.h"

@implementation REDPOSTHTTPRequest

#pragma mark - POST
-(void)callWithRequest:(id<REDRequestProtocol>)request andURL:(NSString *)url andCallback:(REDHTTPRequestProtocolCallback)callback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [request Serializer] == REDXMLSerializer ? [AFXMLParserResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
    [manager POST:url parameters:[request HTTPEncode] success:^(NSURLSessionDataTask *task, id responseObject) {
        callback(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callback(nil, [NSError errorWithDomain:REDErrorDomain code:error.code userInfo :@{ NSLocalizedDescriptionKey : error.localizedDescription , NSLocalizedFailureReasonErrorKey : error.localizedFailureReason}]);
    }];
}


@end
