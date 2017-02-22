//
//  REDServiceCallFactory.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDServiceCallProtocol.h"

@interface REDServiceCallFactory : NSObject

#pragma mark - constructor
-(instancetype)initWithRequestClass:(Class)requestClass;

#pragma mark - service call
-(id<REDServiceCallProtocol>)serviceCall;

#pragma mark - factory method
+(id<REDServiceCallProtocol>)serviceCallForRequestClass:(Class)requestClass;

@end
