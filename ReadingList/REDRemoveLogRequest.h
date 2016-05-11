//
//  REDRemoveLogRequest.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/6/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDRequestProtocol.h"
#import "REDReadProtocol.h"

@interface REDRemoveLogRequest : NSObject

<REDRequestProtocol>

#pragma mark - constructor
-(instancetype)initWithUserId:(NSString *)userId log:(id<REDReadProtocol>)read;

#pragma mark - properties
@property (nonatomic,readonly) id<REDReadProtocol> log;
@property (nonatomic,readonly) NSString * userId;

@end
