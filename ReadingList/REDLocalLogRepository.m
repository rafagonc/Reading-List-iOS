//
//  REDLocalLogRepository.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/6/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLocalLogRepository.h"
#import "REDReadDataAccessObject.h"
#import "REDTransactionManager.h"

@interface REDLocalLogRepository ()

#pragma mark - injected
@property (setter=injected:) id<REDTransactionManager> transactionManager;
@property (setter=injected:) id<REDReadDataAccessObject> readDataAccessObject;

@end

@implementation REDLocalLogRepository

-(void)createForUser:(id<REDUserProtocol>)user log:(id<REDReadProtocol>)log callback:(REDLogRepositoryCreateCallback)callback error:(REDErrorCallback)error {
    @try {
        [self.transactionManager commit];
        callback(log);
    } @catch (NSException *exception) {
        error([exception reason]);
    }
}
-(void)removeForUser:(id<REDUserProtocol>)user log:(id<REDReadProtocol>)read callback:(REDLogRepositoryRemoveCallback)callback error:(REDErrorCallback)error {
    @try {
        [self.readDataAccessObject remove:read];
        callback(read);
    } @catch (NSException *exception) {
        error([exception reason]);
    }
}
-(void)listForUser:(id<REDUserProtocol>)user callback:(REDLogRepositoryListCallback)callback error:(REDErrorCallback)error {
    @try {
        callback([self.readDataAccessObject logsOrderedByDate]);
    } @catch (NSException *exception) {
        error([exception reason]);
    }
}

@end
