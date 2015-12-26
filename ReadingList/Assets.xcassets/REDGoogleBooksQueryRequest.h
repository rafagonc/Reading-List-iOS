//
//  REDAmazonProductSearch.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDRequestProtocol.h"

@interface REDGoogleBooksQueryRequest : NSObject

<REDRequestProtocol>

#pragma mark - constructor
-(instancetype)initWithQuery:(NSString *)query;

#pragma mark - proeprties
@property (nonatomic,strong) NSString *query;

@end
