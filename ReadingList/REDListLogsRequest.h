//
//  REDListLogRequest.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/6/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDRequestProtocol.h"

@interface REDListLogsRequest : NSObject

<REDRequestProtocol>

#pragma mark - constructor
-(instancetype)initWithUserId:(NSString *)userId;

#pragma mark - properites
@property (nonatomic,readonly) NSString * userId;

@end
