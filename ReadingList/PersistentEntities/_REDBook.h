// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to REDBook.h instead.

#import <CoreData/CoreData.h>

extern const struct REDBookAttributes {
	__unsafe_unretained NSString *cover;
	__unsafe_unretained NSString *language;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *pages;
	__unsafe_unretained NSString *pagesRead;
	__unsafe_unretained NSString *snippet;
} REDBookAttributes;

extern const struct REDBookRelationships {
	__unsafe_unretained NSString *author;
	__unsafe_unretained NSString *category;
} REDBookRelationships;

@class REDAuthor;
@class REDCategory;

@interface REDBookID : NSManagedObjectID {}
@end

@interface _REDBook : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) REDBookID* objectID;

@property (nonatomic, strong) NSData* cover;

//- (BOOL)validateCover:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* language;

//- (BOOL)validateLanguage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* pages;

@property (atomic) int16_t pagesValue;
- (int16_t)pagesValue;
- (void)setPagesValue:(int16_t)value_;

//- (BOOL)validatePages:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* pagesRead;

@property (atomic) int16_t pagesReadValue;
- (int16_t)pagesReadValue;
- (void)setPagesReadValue:(int16_t)value_;

//- (BOOL)validatePagesRead:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* snippet;

//- (BOOL)validateSnippet:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) REDAuthor *author;

//- (BOOL)validateAuthor:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) REDCategory *category;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;

@end

@interface _REDBook (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveCover;
- (void)setPrimitiveCover:(NSData*)value;

- (NSString*)primitiveLanguage;
- (void)setPrimitiveLanguage:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitivePages;
- (void)setPrimitivePages:(NSNumber*)value;

- (int16_t)primitivePagesValue;
- (void)setPrimitivePagesValue:(int16_t)value_;

- (NSNumber*)primitivePagesRead;
- (void)setPrimitivePagesRead:(NSNumber*)value;

- (int16_t)primitivePagesReadValue;
- (void)setPrimitivePagesReadValue:(int16_t)value_;

- (NSString*)primitiveSnippet;
- (void)setPrimitiveSnippet:(NSString*)value;

- (REDAuthor*)primitiveAuthor;
- (void)setPrimitiveAuthor:(REDAuthor*)value;

- (REDCategory*)primitiveCategory;
- (void)setPrimitiveCategory:(REDCategory*)value;

@end
