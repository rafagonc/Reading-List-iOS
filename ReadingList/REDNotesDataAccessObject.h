//
//  REDNotesDataAccessObject.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDDataAccessObject.h"
#import "REDBookProtocol.h"

@protocol REDNotesDataAccessObject <REDDataAccessObject>

#pragma mark - create
-(id)createWithText:(NSString *)text andBook:(id<REDBookProtocol>)book;

#pragma mark - fetch
-(id<REDNotesProtocol>)noteWithID:(NSInteger)note_id book:(id<REDBookProtocol>)book;

#pragma mark - update
-(void)updateNote:(NSDictionary *)note_dict book:(id<REDBookProtocol>)book;

#pragma mark - delete
-(void)deleteNotFoundNotesInSequence:(NSArray *)notes forBook:(id<REDBookProtocol>)book;

@end
