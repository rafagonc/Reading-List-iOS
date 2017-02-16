//
//  REDRemoveUserRequest.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDRequestProtocol.h"

@interface REDRemoveUserRequest : NSObject

<REDRequestProtocol>

#pragma mark - constructor
-(instancetype)init __attribute__ ((unavailable("use designated initalizer")));
-(instancetype)initWithUserId:(NSString *)user_id;

#pragma mark - properties
@property (nonatomic,readonly) NSString * user_id;

@end
