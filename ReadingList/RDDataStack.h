//
//  TCKDataStack.h
//  TicketV3
//
//  Created by Rafael Gonzalves on 8/17/15.
//  Copyright (c) 2015 Rafael Gonçalves. All rights reserved.
//

@import CoreData;

@interface RDDataStack : NSObject

#pragma mark - singleton
+(RDDataStack *)sharedManager;

#pragma mark - context
-(NSManagedObjectContext *)managedObjectContext;

#pragma mark - saving
-(void)commit;

@end
