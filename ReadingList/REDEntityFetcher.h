//
//  SHEntityFetcher.h
//  Share
//
//  Created by Rafael Gonzalves on 8/31/15.
//  Copyright (c) 2015 Rafael Gonçalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REDEntityFetcher : NSObject

#pragma mark - builder
+(REDEntityFetcher *)withProtocol:(Protocol *)protocol;
-(REDEntityFetcher *)setFetchLimit:(NSUInteger)fetchLimit;
-(REDEntityFetcher *)setPredicate:(NSPredicate *)predicate;
-(REDEntityFetcher *)setSortDescriptors:(NSArray *)sortDescriptors;
-(REDEntityFetcher *)setColumns:(NSArray<NSString *> *)columns;


#pragma mark - results
-(NSArray *)all;
-(id)first;
-(id)getWithIdentifier:(NSNumber *)identifier;

@end
