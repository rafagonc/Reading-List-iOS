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

@property (nonatomic, nullable) NSString * name;
@property (nonatomic, nullable) NSDate   * firstReadCreated;
@property (nonatomic, nullable) NSData   * coverData;
@property (nonatomic, nullable) NSData   * photoData;
@property (nonatomic, nullable) NSString * authTokenSecret;
@property (nonatomic, nullable) NSString * userId;
@property (nonatomic, nullable) NSString * authToken;
@property (nonatomic) BOOL payed;
@property (nonatomic) BOOL syncable;
@property (nonatomic) BOOL completeSyncing;

@end
