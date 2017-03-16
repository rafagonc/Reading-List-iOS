//
//  REDAuthorDataAccessObject.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDDataAccessObject.h"
#import "REDAuthorProtocol.h"

@protocol REDAuthorDataAccessObject <REDDataAccessObject>

-(NSArray <id<REDAuthorProtocol>> *)authorsSortedByName;
-(id<REDAuthorProtocol>)authorByName:(NSString *)name;
-(NSArray <id<REDAuthorProtocol>> *)authorsByName:(NSString *)name;

@end
