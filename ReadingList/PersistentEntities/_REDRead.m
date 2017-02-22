// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to REDRead.m instead.

#import "_REDRead.h"

const struct REDReadAttributes REDReadAttributes = {
	.bookName = @"bookName",
	.date = @"date",
	.pages = @"pages",
};

@implementation REDReadID
@end

@implementation _REDRead

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"REDRead" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"REDRead";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"REDRead" inManagedObjectContext:moc_];
}

- (REDReadID*)objectID {
	return (REDReadID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"pagesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"pages"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic bookName;

@dynamic date;

@dynamic pages;

- (int64_t)pagesValue {
	NSNumber *result = [self pages];
	return [result longLongValue];
}

- (void)setPagesValue:(int64_t)value_ {
	[self setPages:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitivePagesValue {
	NSNumber *result = [self primitivePages];
	return [result longLongValue];
}

- (void)setPrimitivePagesValue:(int64_t)value_ {
	[self setPrimitivePages:[NSNumber numberWithLongLong:value_]];
}

@end

