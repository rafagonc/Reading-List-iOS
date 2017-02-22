//
//  REDCategoryDataAccessObject.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDDataAccessObject.h"
#import "REDCategoryProtocol.h"

@protocol REDCategoryDataAccessObject <REDDataAccessObject>

-(NSArray <id<REDCategoryProtocol>> *)categoriesByName:(NSString *)name;
-(id<REDCategoryProtocol>)categoryByName:(NSString *)name;
-(NSArray <id<REDCategoryProtocol>> * )categoriesSortedByName;
-(NSString *)mostUsedCategoryName;
-(id<REDCategoryProtocol>)unespecified;

@end
