//
//  REDRLMCategoryDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMCategoryDataAccessObject.h"
#import "REDRLMCategory.h"

@implementation REDRLMCategoryDataAccessObject

#pragma mark - creating
-(id)create {
    return [[REDRLMCategory alloc] init];
}

#pragma mark - queries
-(NSArray *)list {
    return (NSArray *)[REDRLMCategory allObjects];
}
-(NSArray *)listWithPredicate:(NSPredicate *)predicate {
    return (NSArray *)[REDRLMCategory objectsWithPredicate:predicate];
}

#pragma mark - methods
-(NSArray<id<REDCategoryProtocol>> *)categoriesSortedByName {
    return [[self list] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
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
