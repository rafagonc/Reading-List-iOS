//
//  REDBookDataAccessObjectImpl.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookDataAccessObjectImpl.h"

@implementation REDBookDataAccessObjectImpl

#pragma mark - methods
-(NSArray<id<REDBookProtocol>> *)searchBooksWithString:(NSString *)name {
    NSArray * books = [self listWithPredicate:[NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", name]];
    return [books sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"completed" ascending:YES]]];
}
-(NSArray <id<REDBookProtocol>> *)allBooksSorted {
    return [[self list] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"completed" ascending:YES],[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
}
-(NSString *)allBooksNamesConcanated {
    NSArray < NSString * > * bookNames = [[self list] valueForKeyPath:@"@unionOfObjects.name"];
    NSMutableString * concanatedBookNames = [[NSMutableString alloc] init];
    for (NSString *name  in bookNames) {
        [concanatedBookNames appendFormat:@"%@ ,", name];
    }
    return [concanatedBookNames copy];
}

#pragma mark - overrides
-(NSString *)entityName {
    return @"REDBook";
}

@end
