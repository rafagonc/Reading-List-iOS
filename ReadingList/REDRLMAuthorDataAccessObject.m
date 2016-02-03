//
//  REDRLMAuthorDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMAuthorDataAccessObject.h"
#import "REDRLMAuthor.h"

@implementation REDRLMAuthorDataAccessObject

#pragma mark - creating
-(id)create {
    return [[REDRLMAuthor alloc] init];
}

#pragma mark - queries
-(NSArray *)list {
    return (NSArray *)[REDRLMAuthor allObjects];
}
-(NSArray *)listWithPredicate:(NSPredicate *)predicate {
    return (NSArray *)[REDRLMAuthor objectsWithPredicate:predicate];
}

#pragma mark - specific queries
-(NSArray<id<REDAuthorProtocol>> *)authorsSortedByName {
    return [[self list] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
}


@end
