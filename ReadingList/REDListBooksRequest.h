//
//  REDListBooksRequest.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/5/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDBookProtocol.h"
#import "REDRequestProtocol.h"

@interface REDListBooksRequest : NSObject

<REDRequestProtocol>

#pragma mark - constructor
-(instancetype)init __attribute__ ((unavailable("use designated initalizer")));
-(instancetype)initWithUserId:(NSString *)userId;

#pragma mark - properties
@property (nonatomic,readonly) NSString *userId;

@end
