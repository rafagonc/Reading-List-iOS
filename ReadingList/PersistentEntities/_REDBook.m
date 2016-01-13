// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to REDBook.m instead.

#import "_REDBook.h"

const struct REDBookAttributes REDBookAttributes = {
	.cover = @"cover",
	.language = @"language",
	.name = @"name",
	.pages = @"pages",
	.pagesRead = @"pagesRead",
	.rate = @"rate",
	.snippet = @"snippet",
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
	if ([key isEqualToString:@"rateValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rate"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
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

@dynamic rate;

- (float)rateValue {
	NSNumber *result = [self rate];
	return [result floatValue];
}

- (void)setRateValue:(float)value_ {
	[self setRate:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveRateValue {
	NSNumber *result = [self primitiveRate];
	return [result floatValue];
}

- (void)setPrimitiveRateValue:(float)value_ {
	[self setPrimitiveRate:[NSNumber numberWithFloat:value_]];
}

@dynamic snippet;

@dynamic author;

@dynamic category;

@end

