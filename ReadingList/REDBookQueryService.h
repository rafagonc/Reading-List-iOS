//
//  REDBookQueryService.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDBookProtocol.h"

typedef void(^REDBookQueryServiceCallback)(id<REDBookProtocol> book);

@protocol REDBookQueryService <NSObject>

-(void)find:(NSString *)name author:(NSString *)author callback:(REDBookQueryServiceCallback)callback;

@end
