//
//  REDRequestProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDHTTPEncodeProtocol.h"

typedef NS_ENUM(NSUInteger, REDHTTPMethod) {
    REDHTTPMethodGET,
    REDHTTPMethodPOST,
    REDHTTPMethodPUT,
    REDHTTPMethodDELETE
};

@protocol REDRequestProtocol <REDHTTPEncodeProtocol>

-(REDHTTPMethod)HTTPMethod;

@end
