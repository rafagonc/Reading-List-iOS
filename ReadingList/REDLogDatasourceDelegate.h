//
//  REDLogDatasourceDelegate.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/26/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDDatasourceProtocol.h"
#import "REDBookProtocol.h"

@protocol REDLogDatasourceDelegate <NSObject>

-(void)datasource:(id<REDDatasourceProtocol>)datasource didDeleteRead:(id<REDReadProtocol>)read;
-(void)datasource:(id<REDDatasourceProtocol>)datasource wantsToCheckOutBook:(id<REDBookProtocol>)book;

@end
