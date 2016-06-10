//
//  REDLibraryDatasourceFactory.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/10/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDDatasourceProtocol.h"
#import "REDLibraryViewController_Constants.h"

@protocol REDLibraryDatasourceFactory <NSObject>

#pragma mark - datasource
-(id<REDDatasourceProtocol>)datasourceForType:(REDLibraryType)type;

@end
