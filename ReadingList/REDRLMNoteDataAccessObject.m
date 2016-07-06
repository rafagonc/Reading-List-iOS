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
    RLMObject * rlm_object = (RLMObject *)object;
    if ([rlm_object isInvalidated] == NO) {
        [self.transactionManager begin];
        [[RLMRealm defaultRealm] deleteObject:object];
        [self.transactionManager commit];
    }
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
        [self.transactionManager begin];
        REDRLMNote * note = [[REDRLMNote alloc] init];
        [note setIdentifier:[note_dict[@"id"] integerValue]];
        [note setText:note_dict[@"text"]];
        [note setBookName:[book name]];
        [book.notes addObject:note];
        [self.transactionManager commit];
    } else {
        [self.transactionManager begin];
        [note setText:note_dict[@"text"]];
        [note setBookName:[book name]];
        [self.transactionManager commit];
    }
}
-(void)deleteNotFoundNotesInSequence:(NSArray *)notes forBook:(id<REDBookProtocol>)book {
    for (id<REDNotesProtocol> note in [book notes]) {
//        NSDictionary * dict = [[notes filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"id = %@", @([note identifier])]] firstObject];
//        if (!dict) {
//            [self remove:note];
//        }
        NSDictionary * dict;
        for (NSDictionary * note_dit in notes) {
            if ([[note_dit objectForKey:@"id"] integerValue] == [note identifier]) {
                dict = note_dit;
            }
        }
        if (!dict) {
            [self remove:note];
        }

    }
}

@end
