//
//  REDRLMUser.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Realm/Realm.h>
#import "REDUserProtocol.h"

@interface REDRLMUser : RLMObject

<REDUserProtocol>

@property (nonatomic) NSString * name;
@property (nonatomic) NSDate   * firstReadCreated;
@property (nonatomic) NSData   * coverData;
@property (nonatomic) NSData   * photoData;

@end
