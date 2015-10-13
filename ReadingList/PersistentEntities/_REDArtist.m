// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to REDArtist.m instead.

#import "_REDArtist.h"

const struct REDArtistAttributes REDArtistAttributes = {
	.name = @"name",
};

const struct REDArtistRelationships REDArtistRelationships = {
	.books = @"books",
};

@implementation REDArtistID
@end

@implementation _REDArtist

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"REDArtist" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"REDArtist";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"REDArtist" inManagedObjectContext:moc_];
}

- (REDArtistID*)objectID {
	return (REDArtistID*)[super objectID];
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

