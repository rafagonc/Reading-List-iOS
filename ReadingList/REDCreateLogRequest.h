//
//  REDCreateLogRequest.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/6/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDRequestProtocol.h"
#import "REDReadProtocol.h"

@interface REDCreateLogRequest : NSObject

<REDRequestProtocol>

#pragma mark - constructor
-(instancetype)initWithUser:(NSString *)userId logs:(NSArray <id<REDReadProtocol>> *)reads;

#pragma mark - properties
@property (nonatomic,readonly) NSArray <id<REDReadProtocol>> * reads;
@property (nonatomic,readonly) NSString * userId;

@end
