//
//  REDHTTPRequestFactory.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDHTTPRequestFactory.h"

#import "REDGETHTTPRequest.h"
#import "REDPOSTHTTPRequest.h"
#import "REDPUTHTTPRequest.h"
#import "REDDELETEHTTPRequest.h"

@implementation REDHTTPRequestFactory

#pragma mark - factory protocol
-(id<REDHTTPRequestProtocol>)GET {
    return [[REDGETHTTPRequest alloc] init];
}
-(id<REDHTTPRequestProtocol>)POST {
    return [[REDPOSTHTTPRequest alloc] init];
}
-(id<REDHTTPRequestProtocol>)PUT {
    return [[REDPUTHTTPRequest alloc] init];
}
-(id<REDHTTPRequestProtocol>)DELETE {
    return [[REDDELETEHTTPRequest alloc] init];
}

#pragma mark - create
-(id<REDHTTPRequestProtocol>)HTTPMethodFor:(REDHTTPMethod)method {
    if (method == REDHTTPMethodGET) {
        return [self GET];
    } else if (method == REDHTTPMethodDELETE) {
        return [self DELETE];
    } else if (method == REDHTTPMethodPOST) {
        return [self POST];
    } else if (method == REDHTTPMethodPUT) {
        return [self PUT];
    }
    @throw [NSException exceptionWithName:@"HTTP Method not mapped" reason:@"The HTTP method avaliable are GET, POST, PUT, DELETE" userInfo:@{}];
}

@end
