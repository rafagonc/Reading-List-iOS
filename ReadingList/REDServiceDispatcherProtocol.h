//
//  REDServiceDispatcherProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDRequestProtocol.h"

@protocol REDServiceDispatcherProtocol <NSObject>

-(void)callWithRequest:(id<REDRequestProtocol>)request withTarget:(id)target andSelector:(SEL)selector;
-(void)processUnprocessedRequestIfNeeded;

@end
