//
//  REDUserProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/26/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDNamable.h"

@protocol REDUserProtocol <REDNamable>

#pragma mark - properties
@property (nonatomic, nullable) NSString * userId;
@property (nonatomic, nullable) UIImage * photo;
@property (nonatomic, nullable) UIImage * cover;
@property (nonatomic, nullable) NSDate * firstReadCreated;
@property (nonatomic, nullable) NSString * authToken;
@property (nonatomic, nullable) NSString * authTokenSecret;
@property (nonatomic) BOOL payed;
@property (nonatomic) BOOL completeSyncing;

#pragma mark - helpers
-(BOOL)hasName;
-(BOOL)hasPhoto;
-(BOOL)isSyncable;

#pragma mark - setters
-(void)setSyncable:(BOOL)syncable;

#pragma mark - setters
-(void)setAuthToken:(NSString * _Nonnull)authToken andAuthTokenSecret:(NSString * _Nonnull)secret andUserId:(NSString * _Nonnull)userId;


@end
