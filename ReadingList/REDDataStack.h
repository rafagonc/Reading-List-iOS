//
//  TCKDataStack.h
//  TicketV3
//
//  Created by Rafael Gonzalves on 8/17/15.
//  Copyright (c) 2015 Rafael Gonçalves. All rights reserved.
//

@import CoreData;
#import "REDTransactionManager.h"

@interface REDDataStack : NSObject

#pragma mark - singleton
+(REDDataStack *)sharedManager;

#pragma mark - context
-(NSManagedObjectContext *)managedObjectContext;

#pragma mark - saving
-(void)commit;

@end
