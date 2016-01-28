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

-(NSArray <id<REDReadProtocol>> *)logsOrderedByDate;
-(CGFloat)perDay;

@end
