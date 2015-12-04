//
//  NSDictionary+Validation.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/3/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Validation)

-(id)rd_validObjectForKey:(id<NSCopying>)key;

@end
