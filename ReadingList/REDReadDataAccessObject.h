//
//  REDReadDataAccessObject.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDDataAccessObject.h"
#import "REDReadProtocol.h"

@protocol REDReadDataAccessObject <REDDataAccessObject>

-(id<REDReadProtocol>)createWithDict:(NSDictionary *)dict;
-(void)updateLog:(id<REDReadProtocol>)log WithDict:(NSDictionary *)dict;
-(NSArray <id<REDReadProtocol>> *)logsOrderedByDate;
-(id<REDReadProtocol>)logWithIdentifier:(NSUInteger)identifier;
-(id<REDReadProtocol>)logWithDate:(NSDate *)date;
-(CGFloat)perDay;

@end
