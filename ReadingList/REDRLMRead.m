//
//  REDRLMRead.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMRead.h"
#import "REDRLMBook.h"

@implementation REDRLMRead

#pragma mark - relationships
-(void)setBook:(id<REDBookProtocol>)book {
    __book = book;
}
-(id<REDBookProtocol>)book {
    return __book;
}

@end
