// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to REDArtist.h instead.

#import <CoreData/CoreData.h>

extern const struct REDArtistAttributes {
	__unsafe_unretained NSString *name;
} REDArtistAttributes;

extern const struct REDArtistRelationships {
	__unsafe_unretained NSString *books;
} REDArtistRelationships;

@class REDBook;

@interface REDArtistID : NSManagedObjectID {}
@end

@interface _REDArtist : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) REDArtistID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _REDArtist (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(REDBook*)value_;
- (void)removeBooksObject:(REDBook*)value_;

@end

@interface _REDArtist (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end
