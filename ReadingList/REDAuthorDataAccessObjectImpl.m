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

#pragma mark - dao
-(NSString *)entityName {
    return @"REDAuthor";
}

@end
