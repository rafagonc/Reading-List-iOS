//
//  DYPShareFactoryImpl.m
//  Picfind
//
//  Created by Rafael Gonzalves on 3/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDShareFactoryImpl.h"
#import "REDMailShareImpl.h"
#import "REDFacebookShareImpl.h"
#import "REDTwitterShareImpl.h"

@implementation REDShareFactoryImpl

-(id<REDShare>)shareForType:(REDShareType)type {
    switch (type) {
        case REDShareTypeFacebook:
            return [[REDFacebookShareImpl alloc] init];
            break;
        case REDShareTypeMail:
            return [[REDMailShareImpl alloc] init];
            break;
        case REDShareTypeTwitter:
            return [[REDTwitterShareImpl alloc] init];
            break;
            
        default:
            @throw [NSException exceptionWithName:@"DYPErrorName" reason:@"Not mapped enum" userInfo:@{}];
            break;
    }
}

@end
