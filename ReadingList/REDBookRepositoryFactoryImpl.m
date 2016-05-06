//
//  REDBookRepositoryFactory.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/5/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDBookRepositoryFactoryImpl.h"
#import "REDLocalBookRepository.h"

@implementation REDBookRepositoryFactoryImpl

-(id<REDBookRepository>)repository {
    return [[REDLocalBookRepository alloc] init];
}

@end
