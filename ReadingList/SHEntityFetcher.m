//
//  SHEntityFetcher.m
//  Share
//
//  Created by Rafael Gonzalves on 8/31/15.
//  Copyright (c) 2015 Rafael Gonçalves. All rights reserved.
//

#import "SHEntityClassFactory.h"
#import "SHEntityFetcher.h"
#import "SHDataStack.h"

@interface SHEntityFetcher ()

@property (nonatomic,strong) NSString *entityName;
@property (nonatomic,strong) NSFetchRequest *fetchRequest;

@end

@implementation SHEntityFetcher

#pragma mark - constructor
-(instancetype)initWithProtocol:(Protocol *)protocol {
    if (self = [super init]) {
        self.entityName = NSStringFromClass([SHEntityClassFactory entityForProtocol:protocol]);
    } return self;
}

#pragma mark - builder
+(SHEntityFetcher *)withProtocol:(Protocol *)protocol {
    SHEntityFetcher *fetcher = [[self alloc] initWithProtocol:protocol];
    fetcher.fetchRequest = [fetcher baseFetchRequest];
    return fetcher;
}
-(SHEntityFetcher *)setFetchLimit:(NSUInteger)fetchLimit {
    [self.fetchRequest setFetchLimit:fetchLimit];
    return self;
}
-(SHEntityFetcher *)setPredicate:(NSPredicate *)predicate {
    [self.fetchRequest setPredicate:predicate];
    return self;
}
-(SHEntityFetcher *)setSortDescriptors:(NSArray *)sortDescriptors {
    [self.fetchRequest setSortDescriptors:sortDescriptors];
    return self;
}
-(SHEntityFetcher *)setColumns:(NSArray<NSString *> *)columns {
    [self.fetchRequest setPropertiesToFetch:columns];
    return self;
}

#pragma mark - fetching
-(NSArray *)all {
    NSError *error = nil;
    NSArray *fetchedObjects = [[self context] executeFetchRequest:self.fetchRequest error:&error];
    NSAssert(fetchedObjects != nil || error == nil, error.localizedDescription);
    return fetchedObjects;
}
-(id)first {
    NSError *error = nil;
    id fetchedObject = [[self context] executeFetchRequest:self.fetchRequest error:&error].firstObject;
    NSAssert(fetchedObject != nil || error == nil, error.localizedDescription);
    return fetchedObject;
}
-(id)getWithIdentifier:(NSNumber *)identifier {
    NSError *error = nil;
    self.fetchRequest.predicate = [NSPredicate predicateWithFormat:@"identifier = %@", identifier];
    id fetchedObject =[[[self context] executeFetchRequest:self.fetchRequest error:&error] firstObject];
    NSAssert(fetchedObject != nil || error == nil, error.localizedDescription);
    return fetchedObject;
}

#pragma mark - helper
-(NSFetchRequest *)baseFetchRequest {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:self.entityName inManagedObjectContext:[self context]]];
    return fetchRequest;
}

#pragma mark - getters and setters
-(NSManagedObjectContext *)context {
    return [[SHDataStack sharedManager] managedObjectContext];
}

@end
