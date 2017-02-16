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
    return [self linkingObjectsOfClass:@"REDRLMBook" forProperty:@"_category"];
}

-(NSUInteger)hash {
    return self.name.hash;
}
-(BOOL)isEqual:(id)object {
    if (object == nil) return NO;
    return [[(id<REDCategoryProtocol>)object name] isEqual:self.name];
}

@end
