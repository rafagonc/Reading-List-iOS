//
//  REDLogRepository.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/6/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDReadProtocol.h"
#import "REDUserProtocol.h"
#import <Foundation/Foundation.h>

typedef void(^REDLogRepositoryCreateCallback)(id<REDReadProtocol> read);
typedef void(^REDLogRepositoryRemoveCallback)(id<REDReadProtocol> read);
typedef void(^REDLogRepositoryListCallback)(NSArray <id<REDReadProtocol>> * read);

@protocol REDLogRepository <NSObject>

#pragma mark - log
-(void)createForUser:(id<REDUserProtocol>)user log:(id<REDReadProtocol>)log callback:(REDLogRepositoryCreateCallback)callback error:(REDErrorCallback)error;
-(void)removeForUser:(id<REDUserProtocol>)user log:(id<REDReadProtocol>)read callback:(REDLogRepositoryRemoveCallback)callback error:(REDErrorCallback)error;
-(void)listForUser:(id<REDUserProtocol>)user callback:(REDLogRepositoryListCallback)callback error:(REDErrorCallback)error;

@end
