//
//  REDSyncNoteRepository.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDSyncNoteRepository.h"
#import "REDTransactionManager.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDCreateNoteRequest.h"
#import "REDUpdateNoteRequest.h"
#import "REDRemoveNoteRequest.h"
#import "REDServiceResponseProtocol.h"

@interface REDSyncNoteRepository () {
    REDErrorCallback createErrorCallback, updateErrorCallback, removeErrorCallback;
    REDNoteRepositoryCallback createCallback, updateCallback, removeCallback;
}

@property (setter=injected2:) id<REDServiceDispatcherProtocol> serviceDispatcher;
@property (setter=injected1:) id<REDTransactionManager> transactionManager;

@end

@implementation REDSyncNoteRepository

#pragma mark - methods
-(void)createForUser:(id<REDNotesProtocol>)user note:(id<REDNotesProtocol>)note callback:(REDNoteRepositoryCallback)callback error:(REDErrorCallback)errorCallback {
    createErrorCallback = errorCallback;
    createCallback = callback;
    @try {
        REDCreateNoteRequest * createNoteRequest = [[REDCreateNoteRequest alloc] initWithNote:note];
        [self.serviceDispatcher callWithRequest:createNoteRequest withTarget:self andSelector:@selector(createNoteResponse:)];
        [self.transactionManager commit];
        if (callback) callback(note);
    } @catch (NSException *exception) {
        errorCallback([NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}]);
    }
}
-(void)updateForUser:(id<REDNotesProtocol>)user note:(id<REDNotesProtocol>)note callback:(REDNoteRepositoryCallback)callback error:(REDErrorCallback)errorCallback {
    updateErrorCallback = errorCallback;
    updateCallback = callback;
    @try {
        REDUpdateNoteRequest * updateNoteRequest = [[REDUpdateNoteRequest alloc] initWithNote:note withText:[note text]];
        [self.serviceDispatcher callWithRequest:updateNoteRequest withTarget:self andSelector:@selector(updateNoteResponse:)];
        [self.transactionManager commit];
        if (callback) callback(note);
    } @catch (NSException *exception) {
        errorCallback([NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}]);
    }
}
-(void)removeForUser:(id<REDNotesProtocol>)user note:(id<REDNotesProtocol>)note callback:(void (^)())callback error:(REDErrorCallback)errorCallback {
    removeErrorCallback = errorCallback;
    removeCallback = callback;
    @try {
        REDRemoveNoteRequest * removeNoteRequest = [[REDRemoveNoteRequest alloc] initWithNote:note];
        [self.serviceDispatcher callWithRequest:removeNoteRequest withTarget:self andSelector:@selector(removeNoteResponse:)];
        [self.transactionManager commit];
        if (callback) callback();
    } @catch (NSException *exception) {
        errorCallback([NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}]);
    }
}

#pragma mark - responses
-(void)createNoteResponse:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = [notification object];
    if (response) {
        
    } else {
        createErrorCallback([response error]);
    }
}
-(void)updateNoteResponse:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = [notification object];
    if (response) {
        
    } else {
        updateErrorCallback([response error]);
    }
}
-(void)removeNoteResponse:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = [notification object];
    if (response) {
        
    } else {
        removeErrorCallback([response error]);
    }
}

@end
