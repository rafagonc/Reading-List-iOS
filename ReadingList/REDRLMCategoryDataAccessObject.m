//
//  REDRLMCategoryDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMCategoryDataAccessObject.h"
#import "REDRLMCategory.h"
#import "REDRLMArrayHelper.h"
#import "REDTransactionManager.h"

@interface REDRLMCategoryDataAccessObject ()

@property (setter=injected1:) id<REDTransactionManager> transactionManager;
@property (setter=injected2:) id<REDRLMArrayHelper> rlm_arrayHelper;

@end

@implementation REDRLMCategoryDataAccessObject

#pragma mark - creating
-(id)create {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [self.transactionManager begin];
    REDRLMCategory *category = [[REDRLMCategory alloc] init];
    [realm addObject:category];
    [self.transactionManager commit];
    return category;
}

#pragma mark - queries
-(NSArray *)list {
    return [self.rlm_arrayHelper arrayFromResults:[REDRLMCategory allObjects]];
}
-(NSArray *)listWithPredicate:(NSPredicate *)predicate {
    return [[self list] filteredArrayUsingPredicate:predicate];
}

#pragma mark - methods
-(NSArray<id<REDCategoryProtocol>> *)categoriesSortedByName {
    return (NSArray *)[[self list] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
}
-(id<REDCategoryProtocol>)categoryByName:(NSString *)name {
    NSArray * categories = [self categoriesSortedByName];
    for (id<REDCategoryProtocol> category in categories) {
        if ([[category name] isEqualToString:name]) {
            return category;
        }
    }
    return nil;
}
-(NSString *)mostUsedCategoryName {
    NSArray <id<REDCategoryProtocol>> * categories = [self list];
    id<REDCategoryProtocol> categoryWithMostBooks = nil;
    for (id<REDCategoryProtocol> category in categories) {
        if (categoryWithMostBooks == nil || [categoryWithMostBooks books].count < [category books].count) {
            categoryWithMostBooks = category;
        }
    }
    return [categoryWithMostBooks name];
}


@end
