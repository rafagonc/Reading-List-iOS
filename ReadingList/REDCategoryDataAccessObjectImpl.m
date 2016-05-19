//
//  REDCategoryDataAccessObjectImpl.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDCategoryDataAccessObjectImpl.h"

@implementation REDCategoryDataAccessObjectImpl


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
-(id<REDCategoryProtocol>)categoryByName:(NSString *)name {
    return nil;
}

#pragma mark - dao
-(NSString *)entityName {
    return @"REDCategory";
}

@end
