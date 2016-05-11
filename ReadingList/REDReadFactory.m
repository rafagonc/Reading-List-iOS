//
//  REDReadFactory.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDReadFactory.h"
#import "REDReadDataAccessObject.h"
#import "REDReadProtocol.h"
#import "REDCloudDataStack.h"
#import "REDTransactionManager.h"
#import "REDLogRepositoryFactory.h"
#import "REDUserProtocol.h"

@interface REDReadFactory ()

@property (setter=injected:) id<REDUserProtocol> user;
@property (setter=injected:) id<REDReadDataAccessObject> readDataAccessObject;
@property (setter=injected:) id<REDTransactionManager> transactionManager;
@property (setter=injected:) id<REDLogRepositoryFactory> logRepositoryFactory;

@end

@implementation REDReadFactory

-(void)createReadWithPageDiff:(NSInteger)page_diff forBook:(id<REDBookProtocol>)book {
    id<REDReadProtocol> newRead = [self.readDataAccessObject create];
    [self.transactionManager begin];
    [newRead setDate:[NSDate date]];
    [newRead setBook:book];
    [newRead setPagesValue:page_diff];
    [[self.logRepositoryFactory repository] createForUser:self.user log:newRead callback:^(id<REDReadProtocol> read) {
        
    } error:^(NSError *error) {
        
    }];
}

@end
