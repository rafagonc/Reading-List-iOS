// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to REDCategory.h instead.

#import <CoreData/CoreData.h>

extern const struct REDCategoryAttributes {
	__unsafe_unretained NSString *name;
} REDCategoryAttributes;

extern const struct REDCategoryRelationships {
	__unsafe_unretained NSString *books;
} REDCategoryRelationships;

@class REDBook;

@interface REDCategoryID : NSManagedObjectID {}
@end

@interface _REDCategory : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) REDCategoryID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _REDCategory (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(REDBook*)value_;
- (void)removeBooksObject:(REDBook*)value_;

@end

@interface _REDCategory (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end
