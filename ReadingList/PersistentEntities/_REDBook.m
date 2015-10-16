// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to REDBook.m instead.

#import "_REDBook.h"

const struct REDBookAttributes REDBookAttributes = {
	.completed = @"completed",
	.cover = @"cover",
	.language = @"language",
	.name = @"name",
	.pages = @"pages",
	.pagesRead = @"pagesRead",
};

const struct REDBookRelationships REDBookRelationships = {
	.author = @"author",
	.category = @"category",
};

@implementation REDBookID
@end

@implementation _REDBook

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"REDBook" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"REDBook";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"REDBook" inManagedObjectContext:moc_];
}

- (REDBookID*)objectID {
	return (REDBookID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"completedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"completed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"pagesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"pages"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"pagesReadValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"pagesRead"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic completed;

- (BOOL)completedValue {
	NSNumber *result = [self completed];
	return [result boolValue];
}

- (void)setCompletedValue:(BOOL)value_ {
	[self setCompleted:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveCompletedValue {
	NSNumber *result = [self primitiveCompleted];
	return [result boolValue];
}

- (void)setPrimitiveCompletedValue:(BOOL)value_ {
	[self setPrimitiveCompleted:[NSNumber numberWithBool:value_]];
}

@dynamic cover;

@dynamic language;

@dynamic name;

@dynamic pages;

- (int16_t)pagesValue {
	NSNumber *result = [self pages];
	return [result shortValue];
}

- (void)setPagesValue:(int16_t)value_ {
	[self setPages:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePagesValue {
	NSNumber *result = [self primitivePages];
	return [result shortValue];
}

- (void)setPrimitivePagesValue:(int16_t)value_ {
	[self setPrimitivePages:[NSNumber numberWithShort:value_]];
}

@dynamic pagesRead;

- (int16_t)pagesReadValue {
	NSNumber *result = [self pagesRead];
	return [result shortValue];
}

- (void)setPagesReadValue:(int16_t)value_ {
	[self setPagesRead:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePagesReadValue {
	NSNumber *result = [self primitivePagesRead];
	return [result shortValue];
}

- (void)setPrimitivePagesReadValue:(int16_t)value_ {
	[self setPrimitivePagesRead:[NSNumber numberWithShort:value_]];
}

@dynamic author;

@dynamic category;

@end

