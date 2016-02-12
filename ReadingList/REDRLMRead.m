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
    self._book = book;
}
-(id<REDBookProtocol>)book {
    return self._book;
}

@end
