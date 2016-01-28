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
@property UIImage * photo;
@property UIImage * cover;
@property NSDate * firstReadCreated;

#pragma mark - helpers
-(BOOL)hasName;
-(BOOL)hasPhoto;


@end
