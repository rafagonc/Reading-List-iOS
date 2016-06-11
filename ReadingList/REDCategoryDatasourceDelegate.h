//
//  REDCategoryDatasourceDelegate.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/10/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDCategoryProtocol.h"
#import "REDDatasourceProtocol.h"

@protocol REDCategoryDatasourceDelegate <NSObject>

-(void)categoryDatasource:(id<REDDatasourceProtocol>)datasource didSelectCategory:(id<REDCategoryProtocol>)category;

@end
