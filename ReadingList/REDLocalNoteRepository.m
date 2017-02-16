//
//  REDLocalNoteRepsoitory.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLocalNoteRepository.h"
#import "REDTransactionManager.h"

@interface REDLocalNoteRepository ()

@property (setter=injected1:) id<REDTransactionManager> transactionManager;

@end

@implementation REDLocalNoteRepository

-(void)createForUser:(id<REDNotesProtocol>)user note:(id<REDNotesProtocol>)note callback:(REDNoteRepositoryCallback)callback error:(REDErrorCallback)errorCallback {
    @try {
        if (callback) callback(note);
    } @catch (NSException *exception) {
        errorCallback([NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}]);
    }
}
-(void)updateForUser:(id<REDNotesProtocol>)user note:(id<REDNotesProtocol>)note callback:(REDNoteRepositoryCallback)callback error:(REDErrorCallback)errorCallback {
    @try {
        if (callback) callback(note);
    } @catch (NSException *exception) {
        errorCallback([NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}]);
    }
}
-(void)removeForUser:(id<REDNotesProtocol>)user note:(id<REDNotesProtocol>)note callback:(void (^)())callback error:(REDErrorCallback)errorCallback {
    @try {
        if (callback) callback();
    } @catch (NSException *exception) {
        errorCallback([NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}]);
    }
}

@end
