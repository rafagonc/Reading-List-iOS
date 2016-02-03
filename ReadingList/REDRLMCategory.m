//
//  REDRLMCategory.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMCategory.h"

@implementation REDRLMCategory

-(NSArray *)books {
    return [self linkingObjectsOfClass:@"REDBook" forProperty:@"category"];
}

@end
