//
//  REDLUNSegmentedControlDatasource.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUNSegmentedControl.h"

@protocol REDLUNSegmentedControlDatasource <LUNSegmentedControlDelegate, LUNSegmentedControlDataSource>

@property id delegate;

@end
