//
//  REDRLMRead.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Realm/Realm.h>
#import "REDReadProtocol.h"
@class REDRLMBook;

@interface REDRLMRead : RLMObject

<REDReadProtocol>

@property (nonatomic) NSDate *     date;
@property (nonatomic) NSInteger    pagesValue;
@property (nonatomic) REDRLMBook * _book;

@end
