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
@property (nonatomic) UIImage * photo;
@property (nonatomic) UIImage * cover;
@property (nonatomic) NSDate * firstReadCreated;
@property (nonatomic) NSString * authToken;
@property (nonatomic) NSString * authTokenSecret;
@property (nonatomic) NSString * userId;

#pragma mark - helpers
-(BOOL)hasName;
-(BOOL)hasPhoto;

#pragma mark - setters
-(void)setAuthToken:(NSString *)authToken andAuthTokenSecret:(NSString *)secret andUserId:(NSString *)userId;


@end
