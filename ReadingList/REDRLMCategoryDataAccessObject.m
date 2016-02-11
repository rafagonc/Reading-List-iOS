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

@interface REDRLMCategoryDataAccessObject ()

@property (setter=injected:,readonly) id<REDRLMArrayHelper> rlm_arrayHelper;

@end

@implementation REDRLMCategoryDataAccessObject

#pragma mark - creating
-(id)create {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    REDRLMCategory *category = [[REDRLMCategory alloc] init];
    [realm addObject:category];
    [realm commitWriteTransaction];
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
