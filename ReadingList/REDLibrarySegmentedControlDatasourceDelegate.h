//
//  REDLibrarySegmentedControlDatasourceDelegate.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUNSegmentedControl.h"
#import "REDLUNSegmentedControlDatasource.h"

@protocol REDLibrarySegmentedControlDatasourceDelegate <NSObject>

-(void)librarySegmentedControlDatasource:(id<REDLUNSegmentedControlDatasource>)datasource justChoseIndex:(NSInteger)index;
-(void)librarySegmentedControlDatasource:(id<REDLUNSegmentedControlDatasource>)datasource willChooseIndex:(NSInteger)index;


@end