//
//  REDBookCoverFlyweight.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/24/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDBookProtocol.h"

@interface REDBookCoverFlyweight : NSObject

#pragma mark - singleton
+(REDBookCoverFlyweight *)sharedFlyweight;

#pragma mark - adding
-(void)addCoverImage:(UIImage *)image forBook:(id<REDBookProtocol>)book;
-(UIImage *)flyweightCoverImageForBook:(id<REDBookProtocol>)book;

@end
