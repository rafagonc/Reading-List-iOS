//
//  REDNoteRepository.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDUserProtocol.h"
#import "REDNotesProtocol.h"
#import <Foundation/Foundation.h>

typedef void(^REDNoteRepositoryCallback)(id<REDNotesProtocol> note);

@protocol REDNoteRepository <NSObject>

-(void)createForUser:(id<REDUserProtocol>)user note:(id<REDNotesProtocol>)note callback:(REDNoteRepositoryCallback)callback error:(REDErrorCallback)error;
-(void)updateForUser:(id<REDUserProtocol>)user note:(id<REDNotesProtocol>)note callback:(REDNoteRepositoryCallback)callback error:(REDErrorCallback)error;
-(void)removeForUser:(id<REDUserProtocol>)user note:(id<REDNotesProtocol>)note callback:(void(^)())callback error:(REDErrorCallback)error;

@end
