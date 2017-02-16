//
//  REDBookCoverFlyweightFactory.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/24/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDBookProtocol.h"

@interface REDBookCoverFlyweightFactory : NSObject

+(UIImage *)coverImageForBook:(id<REDBookProtocol>)book;

@end
