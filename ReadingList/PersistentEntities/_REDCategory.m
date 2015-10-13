// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to REDCategory.m instead.

#import "_REDCategory.h"

const struct REDCategoryAttributes REDCategoryAttributes = {
	.name = @"name",
};

const struct REDCategoryRelationships REDCategoryRelationships = {
	.books = @"books",
};

@implementation REDCategoryID
@end

@implementation _REDCategory

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"REDCategory" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"REDCategory";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"REDCategory" inManagedObjectContext:moc_];
}

- (REDCategoryID*)objectID {
	return (REDCategoryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic books;

- (NSMutableSet*)booksSet {
	[self willAccessValueForKey:@"books"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"books"];

	[self didAccessValueForKey:@"books"];
	return result;
}

@end

