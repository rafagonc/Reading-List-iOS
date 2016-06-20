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
#import "REDRLMNote.h"

RLM_ARRAY_TYPE(REDRLMNote)

@interface REDRLMBook : RLMObject

<REDBookProtocol>

@property (nonatomic) NSInteger        identifier;
@property (nonatomic, nonnull) NSString *        name;
@property (nonatomic, nullable) NSString *        language;
@property (nonatomic, nonnull) NSString *        snippet;
@property (nonatomic) NSInteger         pagesValue;
@property (nonatomic) NSInteger         pagesReadValue;
@property (nonatomic) double            rate;
@property (nonatomic, nullable) REDRLMAuthor *    _author;
@property (nonatomic, nullable) REDRLMCategory *  _category;
@property (nonatomic,strong)  RLMArray<REDRLMNote *><REDRLMNote> * _notes;
@property (nonatomic, nonnull) NSData *          cover;
@property (nonatomic) BOOL completed;
@property (nonatomic) BOOL unprocessed;
@property (nonatomic) BOOL loved;
@property (nonatomic, nullable) NSString *coverURL;


@end
