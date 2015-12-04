//
//  NSDictionary+Validation.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/3/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "NSDictionary+Validation.h"

@implementation NSDictionary (Validation)

-(id)rd_validObjectForKey:(id<NSCopying>)key {
    id obj = [self objectForKey:key];
    if ([obj isEqual:[NSNull null]] || obj == nil || obj == NULL) {
        return nil;
    }
    
    return obj;
}


@end
