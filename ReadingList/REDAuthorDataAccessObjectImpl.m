//
//  REDAuthorDataAccessObjectImpl.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDAuthorDataAccessObjectImpl.h"

@implementation REDAuthorDataAccessObjectImpl

-(NSArray<id<REDAuthorProtocol>> *)authorsSortedByName {
    return [[self list] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
}
-(id<REDAuthorProtocol>)authorByName:(NSString *)name {
    return [[self listWithPredicate:[NSPredicate predicateWithFormat:@"name LIKE %@", name]] firstObject];
}
-(NSArray<id<REDAuthorProtocol>> *)authorsByName:(NSString *)name {
    return nil;
}

#pragma mark - dao
-(NSString *)entityName {
    return @"REDAuthor";
}

@end
