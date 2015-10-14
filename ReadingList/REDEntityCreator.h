//
//  SHEntityFactory.h
//  Share
//
//  Created by Rafael Gonzalves on 9/3/15.
//  Copyright (c) 2015 Rafael Gonçalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REDEntityCreator : NSObject

#pragma mark -  constrautor
-(instancetype)initWithProtocol:(Protocol *)protocol;

#pragma mark - create
-(id)newEntity;

#pragma mark - factory method
+(id)newEntityWithProtocol:(Protocol *)protocol;

@end
