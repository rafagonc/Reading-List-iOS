//
//  REDCategoryProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDNamable.h"

@protocol REDCategoryProtocol <REDNamable>

-(NSArray *)books;

@property (nonatomic,assign) BOOL custom;

@end
