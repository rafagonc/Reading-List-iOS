// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to REDUser.h instead.

#import <CoreData/CoreData.h>

extern const struct REDUserAttributes {
	__unsafe_unretained NSString *firstReadCreated;
	__unsafe_unretained NSString *name;
} REDUserAttributes;

@interface REDUserID : NSManagedObjectID {}
@end

@interface _REDUser : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) REDUserID* objectID;

@property (nonatomic, strong) NSDate* firstReadCreated;

//- (BOOL)validateFirstReadCreated:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@end

@interface _REDUser (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveFirstReadCreated;
- (void)setPrimitiveFirstReadCreated:(NSDate*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

@end
