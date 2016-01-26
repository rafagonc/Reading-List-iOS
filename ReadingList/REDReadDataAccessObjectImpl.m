//
//  REDReadDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDReadDataAccessObjectImpl.h"

@implementation REDReadDataAccessObjectImpl

-(NSArray<id<REDReadProtocol>> *)logsOrderedByDate {
    return [[self list] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]]];
}
-(NSString *)entityName {
    return @"REDRead";
}

@end
