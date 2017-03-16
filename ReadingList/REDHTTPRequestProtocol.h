//
//  REDHTTPMethodCallProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDRequestProtocol.h"

typedef void(^REDHTTPRequestProtocolCallback)(id responseObject, NSError *error);

@protocol REDHTTPRequestProtocol  <NSObject>

-(void)callWithRequest:(id<REDRequestProtocol>)request andURL:(NSString *)url andCallback:(REDHTTPRequestProtocolCallback)callback;

@end
