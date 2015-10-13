//
//  SHEntityFetcher.h
//  Share
//
//  Created by Rafael Gonzalves on 8/31/15.
//  Copyright (c) 2015 Rafael Gonçalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHEntityFetcher : NSObject

#pragma mark - builder
+(SHEntityFetcher *)withProtocol:(Protocol *)protocol;
-(SHEntityFetcher *)setFetchLimit:(NSUInteger)fetchLimit;
-(SHEntityFetcher *)setPredicate:(NSPredicate *)predicate;
-(SHEntityFetcher *)setSortDescriptors:(NSArray *)sortDescriptors;
-(SHEntityFetcher *)setColumns:(NSArray<NSString *> *)columns;


#pragma mark - results
-(NSArray *)all;
-(id)first;
-(id)getWithIdentifier:(NSNumber *)identifier;

@end
