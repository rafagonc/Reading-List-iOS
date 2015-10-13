// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to REDBook.h instead.

#import <CoreData/CoreData.h>

extern const struct REDBookAttributes {
	__unsafe_unretained NSString *completed;
	__unsafe_unretained NSString *cover;
	__unsafe_unretained NSString *language;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *pages;
	__unsafe_unretained NSString *pagesRead;
} REDBookAttributes;

extern const struct REDBookRelationships {
	__unsafe_unretained NSString *artist;
	__unsafe_unretained NSString *category;
} REDBookRelationships;

@class REDArtist;
@class REDCategory;

@interface REDBookID : NSManagedObjectID {}
@end

@interface _REDBook : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) REDBookID* objectID;

@property (nonatomic, strong) NSNumber* completed;

@property (atomic) BOOL completedValue;
- (BOOL)completedValue;
- (void)setCompletedValue:(BOOL)value_;

//- (BOOL)validateCompleted:(id*)value_ error:(NSError**)error_;

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

@property (nonatomic, strong) REDArtist *artist;

//- (BOOL)validateArtist:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) REDCategory *category;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;

@end

@interface _REDBook (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveCompleted;
- (void)setPrimitiveCompleted:(NSNumber*)value;

- (BOOL)primitiveCompletedValue;
- (void)setPrimitiveCompletedValue:(BOOL)value_;

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

- (REDArtist*)primitiveArtist;
- (void)setPrimitiveArtist:(REDArtist*)value;

- (REDCategory*)primitiveCategory;
- (void)setPrimitiveCategory:(REDCategory*)value;

@end
