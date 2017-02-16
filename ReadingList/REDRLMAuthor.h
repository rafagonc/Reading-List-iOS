//
//  REDRLMAuthor.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Realm/Realm.h>
#import "REDAuthorProtocol.h"

@interface REDRLMAuthor : RLMObject

<REDAuthorProtocol>

@property (nonatomic, nonnull) NSString * name;

@end
