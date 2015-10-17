//
//  REDServiceCall_Protected.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDServiceCall.h"
#import "REDServiceResponseProtocol.h"
#import "REDHTTPRequestProtocol.h"


@interface REDServiceCall ()

#pragma mark - concrete calling
-(void)call:(REDHTTPRequestProtocolCallback)callback;

#pragma mark - result
-(void)success:(id<REDServiceResponseProtocol>)response;
-(void)error:(id<REDServiceResponseProtocol>)response;

#pragma mark - properties
@property (nonatomic,strong) id<REDRequestProtocol> request;
@property (nonatomic,strong) NSString *URL;




@end
