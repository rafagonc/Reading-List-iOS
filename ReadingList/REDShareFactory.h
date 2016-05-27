//
//  DYPShareFactory.h
//  Picfind
//
//  Created by Rafael Gonzalves on 3/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDShare.h"

typedef NS_ENUM(NSUInteger, REDShareType) {
    REDShareTypeMail,
    REDShareTypeTwitter,
    REDShareTypeFacebook,
};

@protocol REDShareFactory <NSObject>

-(id<REDShare>)shareForType:(REDShareType)type;

@end
