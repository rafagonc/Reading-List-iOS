// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to REDAuthor.m instead.

#import "_REDAuthor.h"

const struct REDAuthorAttributes REDAuthorAttributes = {
	.name = @"name",
};

const struct REDAuthorRelationships REDAuthorRelationships = {
	.books = @"books",
};

@implementation REDAuthorID
@end

@implementation _REDAuthor

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"REDAuthor" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"REDAuthor";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"REDAuthor" inManagedObjectContext:moc_];
}

- (REDAuthorID*)objectID {
	return (REDAuthorID*)[super objectID];
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

