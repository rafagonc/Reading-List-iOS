//
//  REDLibraryDatasourceFactory.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/10/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLibraryDatasourceFactoryImpl.h"
#import "REDBookDatasource.h"
#import "REDAuthorDatasource.h"
#import "REDCategoryDatasource.h"
#import "REDLibraryAuthorDatasource.h"

@implementation REDLibraryDatasourceFactoryImpl

-(id<REDDatasourceProtocol>)datasourceForType:(REDLibraryType)type {
    switch (type) {
        case REDLibraryTypeBooks:
            return [[REDBookDatasource alloc] init];
            break;
        case REDLibraryTypeAuthor:
            return [[REDLibraryAuthorDatasource alloc] init];
            break;
        case REDLibraryTypeCategories:
            return [[REDCategoryDatasource alloc] init];
            break;
        default:
            break;
    }
}

@end
