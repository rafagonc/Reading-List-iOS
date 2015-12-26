//
//  REDServiceCallFactory.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDServiceCallFactory.h"
#import "REDImageSearchRequest.h"
#import "REDImageSearchCall.h"
#import "REDGoogleBooksQueryRequest.h"
#import "REDGoogleBooksQueryCall.h"

@interface REDServiceCallFactory ()

#pragma mark - properties
@property (nonatomic,unsafe_unretained) Class requestClass;
@property (nonatomic,strong) NSDictionary<NSString *, Class> *bindings;

@end

@implementation REDServiceCallFactory

#pragma mark - constructor
-(instancetype)initWithRequestClass:(Class)requestClass {
    if (self = [super init]) {
        self.requestClass = requestClass;
        self.bindings = @{
                          NSStringFromClass([REDImageSearchRequest class]) : [REDImageSearchCall class],
                          NSStringFromClass([REDGoogleBooksQueryRequest class]) : [REDGoogleBooksQueryCall class]

                          };
    } return self;
}

#pragma mark - service call
-(id<REDServiceCallProtocol>)serviceCall {
    id<REDServiceCallProtocol> sc = [[self.bindings[NSStringFromClass(self.requestClass)] alloc] init];
    NSAssert(sc != Nil || sc != nil, @"Service Call not Mapped");
    return sc;
}

#pragma mark - factory method
+(id<REDServiceCallProtocol>)serviceCallForRequestClass:(Class)requestClass {
    return [[[self alloc] initWithRequestClass:requestClass] serviceCall];
}

@end
