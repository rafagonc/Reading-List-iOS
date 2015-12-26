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

typedef NS_ENUM(NSUInteger, REDSerializer) {
    REDJSONSerializer,
    REDXMLSerializer,
};

@protocol REDRequestProtocol <REDHTTPEncodeProtocol>

-(REDHTTPMethod)HTTPMethod;
-(REDSerializer)Serializer;
-(NSString *)URL;

@end
