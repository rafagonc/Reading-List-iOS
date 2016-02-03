//
//  REDRLMBook.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Realm/Realm.h>
#import "REDRLMAuthor.h"
#import "REDRLMCategory.h"
#import "REDRLMRead.h"
#import <CoreGraphics/CoreGraphics.h>
#import "REDBookProtocol.h"

@interface REDRLMBook : RLMObject

<REDBookProtocol>

@property (nonatomic) NSString *        name;
@property (nonatomic) NSString *        language;
@property (nonatomic) NSString *        snippet;
@property (nonatomic) NSUInteger        pagesValue;
@property (nonatomic) NSUInteger        pagesReadValue;
@property (nonatomic) double            rate;
@property (nonatomic) REDRLMAuthor *    _author;
@property (nonatomic) REDRLMCategory *  _category;
@property (nonatomic) NSData *          cover;


@end