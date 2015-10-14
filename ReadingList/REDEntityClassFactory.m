//
//  REDEntityClassFactory.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDEntityClassFactory.h"

#import "REDBookProtocol.h"
#import "REDBook.h"

#import "REDArtistProtocol.h"
#import "REDArtist.h"

#import "REDCategoryProtocol.h"
#import "REDCategory.h"

@interface REDEntityClassFactory ()

@property (nonatomic) Protocol *protocol;
@property (nonatomic) NSDictionary * map;

@end

@implementation REDEntityClassFactory

#pragma mark - constructor
-(instancetype)initWithProtocol:(Protocol *)protocol {
    if (self = [super init]) {
        self.protocol = protocol;
        self.map = @{
                     NSStringFromProtocol(@protocol(REDBookProtocol)) : [REDBook class],
                     NSStringFromProtocol(@protocol(REDArtistProtocol)) : [REDArtist class],
                     NSStringFromProtocol(@protocol(REDCategoryProtocol)) : [REDCategory class],
                     };
    } return self;
}

#pragma mark - methods
-(Class)entityClass {
    Class entityClass = [self.map objectForKey:NSStringFromProtocol(self.protocol)];
    NSAssert(entityClass != Nil || entityClass != nil, @"Protocol not mapped");
    return entityClass;
}

#pragma mark - factory method
+(Class)entityClassForProtocol:(Protocol *)protocol {
    return [[[self alloc] initWithProtocol:protocol] entityClass];
}

@end
