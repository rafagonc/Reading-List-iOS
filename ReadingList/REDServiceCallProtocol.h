//
//  REDServiceCallProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDRequestProtocol.h"

@protocol REDServiceCallProtocol <NSObject>

-(void)startWithRequest:(id<REDRequestProtocol>)request withCompletion:(void(^)(BOOL success))completion;
-(BOOL)canCacheResult;

@end
