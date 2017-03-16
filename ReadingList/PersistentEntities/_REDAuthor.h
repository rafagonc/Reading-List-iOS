// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to REDAuthor.h instead.

#import <CoreData/CoreData.h>

extern const struct REDAuthorAttributes {
	__unsafe_unretained NSString *name;
} REDAuthorAttributes;

extern const struct REDAuthorRelationships {
	__unsafe_unretained NSString *books;
} REDAuthorRelationships;

@class REDBook;

@interface REDAuthorID : NSManagedObjectID {}
@end

@interface _REDAuthor : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) REDAuthorID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _REDAuthor (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(REDBook*)value_;
- (void)removeBooksObject:(REDBook*)value_;

@end

@interface _REDAuthor (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end
