//
//  REDTransientBookDatasourceDelegate.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/26/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDDatasourceProtocol.h"
#import "REDTransientBook.h"
#import "REDTopRatedBook.h"

@protocol REDTransientBookDatasourceDelegate <NSObject>

-(void)datasource:(id<REDDatasourceProtocol>)datasource wantsToAddTransientBook:(REDTransientBook *)transientBook;
-(void)datasource:(id<REDDatasourceProtocol>)datasource wantsToCheckOutTopRatedBook:(id<REDTopRatedBook>)book;

@end
