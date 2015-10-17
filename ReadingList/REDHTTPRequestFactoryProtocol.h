//
//  REDHTTPRequestFactoryProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDHTTPRequestProtocol.h"

@protocol REDHTTPRequestFactoryProtocol <NSObject>

-(id<REDHTTPRequestProtocol>)GET;
-(id<REDHTTPRequestProtocol>)PUT;
-(id<REDHTTPRequestProtocol>)POST;
-(id<REDHTTPRequestProtocol>)DELETE;
-(id<REDHTTPRequestProtocol>)HTTPMethodFor:(REDHTTPMethod)method;

@end
