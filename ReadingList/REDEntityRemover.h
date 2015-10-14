//
//  SHEntityRemover.h
//  Share
//
//  Created by Rafael Gonzalves on 9/14/15.
//  Copyright (c) 2015 Rafael Gonçalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REDEntityRemover : NSObject

#pragma mark - constructor
-(instancetype)initWithObject:(id)object;

#pragma mark - remove
-(void)remove;

#pragma mark - factory method
+(void)removeObject:(id)object;

@end

