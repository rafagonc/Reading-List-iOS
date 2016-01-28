//
//  REDBookDatasourceDelegate.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/17/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDDatasourceProtocol.h"
#import "REDBookProtocol.h"
#import <Foundation/Foundation.h>

@protocol REDBookDatasourceDelegate <NSObject>

-(void)datasource:(id<REDDatasourceProtocol>)datasource didSelectBook:(id<REDBookProtocol>)book;
-(BOOL)datasourceCanEditBooks:(id<REDDatasourceProtocol>)datasource;
-(BOOL)datasourceShouldShowAccessoryType:(id<REDDatasourceProtocol>)datasource;

@optional
-(void)datasource:(id<REDDatasourceProtocol>)datasource didDeleteBook:(id<REDBookProtocol>)book;


@end
