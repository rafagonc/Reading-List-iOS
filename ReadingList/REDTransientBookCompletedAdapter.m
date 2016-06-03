//
//  REDTransientBookCompletedAdapter.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDTransientBookCompletedAdapter.h"

@implementation REDTransientBookCompletedAdapter

#pragma mark - constructor
-(instancetype)initWithTransientBook:(REDTransientBook *)book {
    if (self = [super init]) {
        _book = book;
    } return self;
}


@end
