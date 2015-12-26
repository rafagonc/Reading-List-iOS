//
//  REDCloudDataStack.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/26/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface REDCloudDataStack : NSObject

#pragma mark - singleton
+(REDCloudDataStack *)sharedManager;

#pragma mark - context
-(NSManagedObjectContext *)managedObjectContext;

#pragma mark - saving
-(void)commit;

@end
