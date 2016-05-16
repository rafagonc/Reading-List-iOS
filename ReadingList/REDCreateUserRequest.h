//
//  REDCreateUserRequest.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDRequestProtocol.h"
#import "REDUserProtocol.h"

@interface REDCreateUserRequest : NSObject

<REDRequestProtocol>

#pragma mark - constructor
-(instancetype)init __attribute__ ((unavailable("use designated initalizer")));
-(instancetype)initWithUser:(id<REDUserProtocol>)user;

#pragma mark - properties
@property (nonatomic,readonly) id<REDUserProtocol> user;

@end
