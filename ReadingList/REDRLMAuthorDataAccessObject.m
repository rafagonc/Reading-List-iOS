//
//  REDRLMAuthorDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMAuthorDataAccessObject.h"
#import "REDRLMAuthor.h"
#import "REDRLMArrayHelper.h"

@interface REDRLMAuthorDataAccessObject ()

@property (setter=injected:) id<REDRLMArrayHelper> rlm_arrayHelper;

@end

@implementation REDRLMAuthorDataAccessObject

#pragma mark - creating
-(id)create {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    REDRLMAuthor *author = [[REDRLMAuthor alloc] init];
    [realm addObject:author];
    [realm commitWriteTransaction];
    return author;
}

#pragma mark - queries
-(id)list {
    return [self.rlm_arrayHelper arrayFromResults:[REDRLMAuthor allObjects]];
}
-(id)listWithPredicate:(NSPredicate *)predicate {
    return [[self list] filteredArrayUsingPredicate:predicate];
}
-(id<REDAuthorProtocol>)authorByName:(NSString *)name {
    return [[self listWithPredicate:[NSPredicate predicateWithFormat:@"name LIKE %@", name]] firstObject];
}

#pragma mark - specific queries
-(NSArray<id<REDAuthorProtocol>> *)authorsSortedByName {
    return (NSArray *)[[self list] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
}


@end
