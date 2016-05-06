//
//  REDBookRepository.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/5/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDBookProtocol.h"
#import "REDUserProtocol.h"

typedef void(^REDBookRepositoryListCallback)(NSArray <id<REDBookProtocol>> * books);
typedef void(^REDBookRepositoryCreateUpdateCallback)(id<REDBookProtocol> createdBook);
typedef void(^REDBookRepositoryDeleteCallback)(id<REDBookProtocol> deletedBook);

@protocol REDBookRepository <NSObject>

#pragma mark - create
-(void)createForUser:(id<REDUserProtocol>)user book:(id<REDBookProtocol>)book callback:(REDBookRepositoryCreateUpdateCallback)callback error:(REDErrorCallback)callback;

#pragma mark - read
-(void)listForUser:(id<REDUserProtocol>)user callback:(REDBookRepositoryListCallback)callback error:(REDErrorCallback)callback;

#pragma mark - update
-(void)updateForUser:(id<REDUserProtocol>)user book:(id<REDBookProtocol>)book callback:(REDBookRepositoryCreateUpdateCallback)callback error:(REDErrorCallback)callback;

#pragma mark - delete
-(void)removeForUser:(id<REDUserProtocol>)user book:(id<REDBookProtocol>)book callback:(REDBookRepositoryDeleteCallback)callback error:(REDErrorCallback)error;

@end
