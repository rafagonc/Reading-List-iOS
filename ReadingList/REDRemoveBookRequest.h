//
//  REDRemoveBookRequest.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/5/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDBookProtocol.h"
#import "REDRequestProtocol.h"

@interface REDRemoveBookRequest : NSObject

<REDRequestProtocol>

#pragma mark - constructor
-(instancetype)init __attribute__ ((unavailable("use designated initalizer")));
-(instancetype)initWithUserId:(NSString *)userId book:(id<REDBookProtocol>)book;

#pragma mark - properties
@property (nonatomic,readonly) NSString *userId;
@property (nonatomic,readonly) id<REDBookProtocol> book;

@end
