//
//  REDBookCoverFlyweightFactory.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/24/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDBookCoverFlyweightFactory.h"
#import "REDBookCoverFlyweight.h"

@implementation REDBookCoverFlyweightFactory

+(UIImage *)coverImageForBook:(id<REDBookProtocol>)book {
    return [[REDBookCoverFlyweight sharedFlyweight] flyweightCoverImageForBook:book];
}

@end
