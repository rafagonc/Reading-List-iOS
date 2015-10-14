//
//  SHEntityRemover.m
//  Share
//
//  Created by Rafael Gonzalves on 9/14/15.
//  Copyright (c) 2015 Rafael Gonçalves. All rights reserved.
//

#import "REDEntityRemover.h"
#import "REDDataStack.h"

@interface REDEntityRemover ()

@property (nonatomic,readonly) NSManagedObjectContext *context;
@property (nonatomic,strong) id object;

@end

@implementation REDEntityRemover

#pragma mark - constructor
-(instancetype)initWithObject:(id)object {
    if (self = [super init]) {
        self.object = object;
    } return self;
}

#pragma mark - remove
-(void)remove {
    NSError *error;
    [self.context deleteObject:self.object];
    [self.context save:&error];
    NSAssert(error == nil, @"%@", error.localizedDescription);
}

#pragma mark factory method
+(void)removeObject:(id)object {
    [[[self alloc] initWithObject:object] remove];
}

#pragma mark - getters
-(NSManagedObjectContext *)context {
    return [[REDDataStack sharedManager] managedObjectContext];
}

@end
