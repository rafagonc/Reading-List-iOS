//
//  REDUserUpload.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/1/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDUserProtocol.h"
#import "REDReadProtocol.h"
#import "REDBookProtocol.h"

@protocol REDUserUpload <NSObject>

-(void)createUser:(id<REDUserProtocol>)user withBooks:(NSArray<id<REDBookProtocol>> *)books andLogs:(NSArray<id<REDReadProtocol>> *)logs andUserId:(NSString *)userId andAuthToken:(NSString *)authToken andAuthTokenSecret:(NSString *)authTokenSecret completion:(void(^)(BOOL success, NSError * error))completion;

@end
