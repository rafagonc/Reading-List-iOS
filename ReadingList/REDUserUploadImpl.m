//
//  REDUserUpload.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/1/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDUserUploadImpl.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDUserProtocol.h"

@interface REDUserUploadImpl ()

@property (setter=injected:) id<REDServiceDispatcherProtocol> serviceDispatcher;
@property (setter=injected:) id<REDUserProtocol> user;



@end

@implementation REDUserUploadImpl

-(void)createUser:(id<REDUserProtocol>)user withBooks:(NSArray<id<REDBookProtocol>> *)books andLogs:(NSArray<id<REDReadProtocol>> *)logs andUserId:(NSString *)userId andAuthToken:(NSString *)authToken andAuthTokenSecret:(NSString *)authTokenSecret {
    
}

@end
