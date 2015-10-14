//
//  REDEntityClassFactory.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REDEntityClassFactory : NSObject

#pragma mark - constructor
-(instancetype)initWithProtocol:(Protocol *)protocol;

#pragma mark - methods
-(Class)entityClass;

#pragma mark - factory method
+(Class)entityClassForProtocol:(Protocol *)protocol;

@end
