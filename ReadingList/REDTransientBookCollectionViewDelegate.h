//
//  REDTransientBookCollectionViewDelegate.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDCollectionViewDatasourceProtocol.h"
#import "REDTransientBook.h"

@protocol REDTransientBookCollectionViewDelegate <NSObject>

-(void)transientBookDatasource:(id<REDCollectionViewDatasourceProtocol>)datasource justAddedBook:(REDTransientBook *)book;
-(void)transientBookDatasource:(id<REDCollectionViewDatasourceProtocol>)datasource justRemovedBook:(REDTransientBook *)book;


@end
