//
//  REDAuthorDatasourceDelegate.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/10/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDAuthorProtocol.h"

@protocol REDAuthorDatasourceDelegate <NSObject>

-(void)authorDatasource:(id<REDDatasourceProtocol>)authorDatasource didSelectAuthor:(id<REDAuthorProtocol>)author;
-(void)authorDatasource:(id<REDDatasourceProtocol>)authorDatasource wantsToDeleteAuthor:(id<REDAuthorProtocol>)author;
-(void)authorDatasource:(id<REDDatasourceProtocol>)authorDatasource wantsToEditAuthor:(id<REDAuthorProtocol>)author;

@end
