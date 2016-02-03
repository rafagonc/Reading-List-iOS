//
//  REDRLMCategory.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Realm/Realm.h>
#import "REDCategoryProtocol.h"

@interface REDRLMCategory : RLMObject

<REDCategoryProtocol>

@property (nonatomic) NSString *name;

@end
