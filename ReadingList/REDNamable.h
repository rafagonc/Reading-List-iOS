//
//  REDNamable.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol REDNamable <NSObject>

@optional

#pragma mark - properties
@property (nonatomic, nonnull) NSString *name;

@end
