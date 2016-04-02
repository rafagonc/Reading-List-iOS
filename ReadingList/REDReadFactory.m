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

@interface REDReadFactory ()

@property (setter=injected:) id<REDReadDataAccessObject> readDataAccessObject;
@property (setter=injected:) id<REDTransactionManager> transactionManager;

@end

@implementation REDReadFactory

-(void)createReadWithPageDiff:(NSInteger)page_diff forBook:(id<REDBookProtocol>)book {
    id<REDReadProtocol> newRead = [self.readDataAccessObject create];
    [self.transactionManager begin];
    [newRead setDate:[NSDate date]];
    [newRead setBook:book];
    [newRead setPagesValue:page_diff];
    [self.transactionManager commit];
}

@end
