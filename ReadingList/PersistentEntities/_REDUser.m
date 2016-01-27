// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to REDUser.m instead.

#import "_REDUser.h"

const struct REDUserAttributes REDUserAttributes = {
	.name = @"name",
};

@implementation REDUserID
@end

@implementation _REDUser

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"REDUser" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"REDUser";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"REDUser" inManagedObjectContext:moc_];
}

- (REDUserID*)objectID {
	return (REDUserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@end

