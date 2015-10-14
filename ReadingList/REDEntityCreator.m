//
//  SHEntityFactory.m
//  Share
//
//  Created by Rafael Gonzalves on 9/3/15.
//  Copyright (c) 2015 Rafael Gonçalves. All rights reserved.
//

#import "REDEntityCreator.h"
#import "REDEntityClassFactory.h"
#import <CoreData/CoreData.h>
#import "REDDataStack.h"
#import "REDEntityFetcher.h"

@interface REDEntityCreator ()

@property (nonatomic) Protocol * protocol;
@property (nonatomic) NSString *entityName;;
@property (nonatomic,readonly) NSManagedObjectContext *context;

@end

@implementation REDEntityCreator

#pragma mark - constructor
-(instancetype)initWithProtocol:(Protocol *)protocol {
    if (self = [super init]) {
        self.protocol = protocol;
        self.entityName = NSStringFromClass([REDEntityClassFactory entityClassForProtocol:protocol]);
    } return self;
}

#pragma mark - create
-(id)newEntity {
    id entity = [[NSClassFromString(self.entityName) alloc] initWithEntity:[NSEntityDescription entityForName:self.entityName inManagedObjectContext:self.context] insertIntoManagedObjectContext:self.context];
    return entity;
}

#pragma mark - factory method
+(id)newEntityWithProtocol:(Protocol *)protocol {
    return [[[self alloc] initWithProtocol:protocol] newEntity];
}

#pragma mark - geterrs
-(NSManagedObjectContext *)context {
    return [[REDDataStack sharedManager] managedObjectContext];
}

@end

