// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to REDRead.h instead.

#import <CoreData/CoreData.h>

extern const struct REDReadAttributes {
	__unsafe_unretained NSString *bookName;
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *pages;
} REDReadAttributes;

@interface REDReadID : NSManagedObjectID {}
@end

@interface _REDRead : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) REDReadID* objectID;

@property (nonatomic, strong) NSString* bookName;

//- (BOOL)validateBookName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* pages;

@property (atomic) int64_t pagesValue;
- (int64_t)pagesValue;
- (void)setPagesValue:(int64_t)value_;

//- (BOOL)validatePages:(id*)value_ error:(NSError**)error_;

@end

@interface _REDRead (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveBookName;
- (void)setPrimitiveBookName:(NSString*)value;

- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;

- (NSNumber*)primitivePages;
- (void)setPrimitivePages:(NSNumber*)value;

- (int64_t)primitivePagesValue;
- (void)setPrimitivePagesValue:(int64_t)value_;

@end
