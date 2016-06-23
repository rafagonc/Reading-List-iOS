//
//  REDRLMNoteDataAccessObject.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMNoteDataAccessObject.h"
#import "REDBookProtocol.h"
#import "REDRLMArrayHelper.h"
#import "REDTransactionManager.h"
#import "REDUserProtocol.h"
#import "REDRLMNote.h"
#import "REDNotesProtocol.h"

@interface REDRLMNoteDataAccessObject ()

@property (setter=injected6:) id<REDUserProtocol> user;
@property (setter=injected1:) id<REDRLMArrayHelper> rlm_arrayHelper;
@property (setter=injected4:) id<REDTransactionManager> transactionManager;

@end


@implementation REDRLMNoteDataAccessObject

-(void)remove:(id)object {
    [self.transactionManager begin];
    [[RLMRealm defaultRealm] deleteObject:object];
    [self.transactionManager commit];
}
-(id)create {
    [self.transactionManager begin];
    REDRLMNote * note = [[REDRLMNote alloc] init];
    [self.transactionManager commit];
    return note;
}
-(id)createWithText:(NSString *)text andBook:(id<REDBookProtocol>)book {
    REDRLMNote *note = [self create];
    [self.transactionManager begin];
    [note setText:text];
    [note setBookName:[book name]];
    [[book notes] addObject:note];
    return note;
}
-(NSArray *)list {
    return [self.rlm_arrayHelper arrayFromResults:[REDRLMNote allObjects]];
}
-(NSArray *)listWithPredicate:(NSPredicate *)predicate {
    return [[self.rlm_arrayHelper arrayFromResults:[REDRLMNote allObjects]] filteredArrayUsingPredicate:predicate];
}
-(id<REDNotesProtocol>)noteWithID:(NSInteger)note_id book:(id<REDBookProtocol>)book {
    for (REDRLMNote * note in book.notes) {
        if (note.identifier == note_id) {
            return note;
        }
    }
    return nil;
}
-(void)updateNote:(NSDictionary *)note_dict book:(id<REDBookProtocol>)book {
    REDRLMNote * note = [self noteWithID:[note_dict[@"id"] integerValue] book:book];
    if (!note) {
        REDRLMNote * note = [[REDRLMNote alloc] init];
        [note setIdentifier:[note_dict[@"id"] integerValue]];
        [note setText:note_dict[@"text"]];
        [note setBookName:[book name]];
        [book.notes addObject:note];
    } else {
        [note setText:note_dict[@"text"]];
        [note setBookName:[book name]];
    }
}

@end
