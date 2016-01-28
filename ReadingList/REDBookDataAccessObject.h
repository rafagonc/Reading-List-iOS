//
//  REDBookDataAccessObject.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDDataAccessObject.h"
#import "REDBookProtocol.h"

@protocol REDBookDataAccessObject <REDDataAccessObject>

-(NSArray <id<REDBookProtocol>> *)allBooksSorted;
-(NSArray <id<REDBookProtocol>> *)searchBooksWithString:(NSString *)name;
-(NSUInteger)totalPages;

@end
