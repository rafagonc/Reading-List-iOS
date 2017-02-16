//
//  REDBookQueryService.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDBookQueryServiceImpl.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDGoogleBooksQueryRequest.h"
#import "REDServiceResponseProtocol.h"

@interface REDBookQueryServiceImpl ()

#pragma mark - properties
@property (nonatomic,copy) REDBookQueryServiceCallback callbck;
@property (nonatomic,copy) NSString *query;

#pragma mark - injected
@property (setter=injected:) id<REDServiceDispatcherProtocol> dispatcher;

@end

@implementation REDBookQueryServiceImpl

#pragma mark - find
-(void)find:(NSString *)name author:(NSString *)author callback:(REDBookQueryServiceCallback)callback {
    self.callbck = callback;
    self.query = name;
    REDGoogleBooksQueryRequest *request = [[REDGoogleBooksQueryRequest alloc] initWithQuery:[NSString stringWithFormat:@"%@ %@", name, author]];
    [self.dispatcher callWithRequest:request withTarget:self andSelector:@selector(response:)];
}
-(void)response:(NSNotification *)notif {
    BOOL finded = NO;
    id<REDServiceResponseProtocol> response = [notif object];
    if ([response success]) {
        for (id<REDBookProtocol> book in [response data]) {
            if ([[book name] isEqualToString:self.query]) {
                if (self.callbck) self.callbck(book);
                finded = YES;
                break;
            }
        }
        if (!finded) {
            if (self.callbck) self.callbck(nil);
        }
    } else {
        if (self.callbck) self.callbck(nil);
    }
}

@end
