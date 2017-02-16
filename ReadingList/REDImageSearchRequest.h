//
//  REDImageSearchRequest.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDRequestProtocol.h"

@interface REDImageSearchRequest : NSObject

<REDRequestProtocol>

#pragma mark - constructor
-(instancetype)initWithQuery:(NSString *)query ;

#pragma mark - properties
@property (nonatomic,readonly) NSString *query;
@property (nonatomic,readonly) NSUInteger limit;
@property (nonatomic,readonly) NSUInteger page;

#pragma mark - methods
-(void)nextPage;

@end
