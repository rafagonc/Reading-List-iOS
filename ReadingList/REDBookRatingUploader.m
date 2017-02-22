//
//  REDBookRatingUploader.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDBookRatingUploader.h"
#import "REDServiceResponseProtocol.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDBookRatingRequest.h"
#import "REDValidator.h"

@interface REDBookRatingUploader ()

#pragma mark - injected
@property (setter=injected:) id<REDServiceDispatcherProtocol> serviceDispatcher;
@property (setter=injected_rating:) id<REDValidator> validator;

@end

@implementation REDBookRatingUploader

#pragma mark - singleton
+(REDBookRatingUploader *)sharedUploader {
    static REDBookRatingUploader *uploader;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uploader = [[self alloc] init];
    });
    return uploader;
}

#pragma mark - methods
-(void)uploadBook:(id<REDBookProtocol>)book forRating:(CGFloat)rating {
    NSError *error;
    if ([self.validator validate:book error:&error]) {
        REDBookRatingRequest * request = [[REDBookRatingRequest alloc] initWithBook:book andRating:rating];
        [self.serviceDispatcher callWithRequest:request withTarget:self andSelector:@selector(response:)];
    } else {
        // yeah, do nothing
    }
}
-(void)response:(NSNotification *)notif {
    id<REDServiceResponseProtocol> response = notif.object;
    if ([response success]) {
        NSLog(@"Book Uploaded");
    } else {
        NSLog(@"Book Upload Failed");
    }
}

@end
