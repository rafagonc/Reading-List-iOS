//
//  REDDefaultDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDDefaultDataAccessObject.h"
#import "REDDataStack.h"
#import "REDCloudDataStack.h"

@implementation REDDefaultDataAccessObject

#pragma mark - constructor
-(instancetype)init {
    if (self = [super init]) {
        self.cloudEnabled = NO;
    } return self;
}

#pragma mark - methods
-(id)create {
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:[self context]];
}
-(NSArray *)list {
    NSFetchRequest *fetchRequest = [self baseFetchRequest];
    NSError *error = nil;
    NSArray *fetchedObjects = [[self context] executeFetchRequest:fetchRequest error:&error];
    NSAssert(fetchedObjects != nil || error == nil, error.localizedDescription);
    return fetchedObjects;
}
-(NSArray *)listWithPredicate:(NSPredicate *)predicate {
    NSFetchRequest *fetchRequest = [self baseFetchRequest];
    fetchRequest.predicate = predicate;
    NSError *error = nil;
    NSArray *fetchedObjects = [[self context] executeFetchRequest:fetchRequest error:&error];
    NSAssert(fetchedObjects != nil || error == nil, error.localizedDescription);
    return fetchedObjects;
}
-(id)first {
    return [[self list] firstObject];
}
-(void)remove:(id)object {
    if (object) [[self context] deleteObject:object];
    self.cloudEnabled ? [[REDCloudDataStack sharedManager] commit] : [[REDDataStack sharedManager] commit];
}
-(NSString *)entityName {
    @throw [NSException exceptionWithName:@"Abstract Class" reason:@"Need to override this method" userInfo:@{}];
}

#pragma mark - helpers
-(NSFetchRequest *)baseFetchRequest {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:[self entityName] inManagedObjectContext:[self context]]];
    return fetchRequest;
}
-(NSManagedObjectContext *)context {
    if (self.cloudEnabled) {
        return [[REDCloudDataStack sharedManager] managedObjectContext];
    } else {
        return [[REDDataStack sharedManager] managedObjectContext];;
    }
}


@end
