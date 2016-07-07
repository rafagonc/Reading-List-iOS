//
//  REDAuthorRemover.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 7/7/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDAuthorRemoverImpl.h"
#import "REDAuthorDataAccessObject.h"
#import "REDBookProtocol.h"
#import "REDBookDataAccessObject.h"
#import "REDBookRepositoryFactory.h"
#import "REDUserProtocol.h"

@interface REDAuthorRemoverImpl ()

<UIAlertViewDelegate>

#pragma amrk - properties
@property (nonatomic,strong) id<REDAuthorProtocol> author;
@property (nonatomic,copy) void (^callback)();

#pragma mark - injected
@property (setter=injected3:) id<REDUserProtocol> user;
@property (setter=injected1:) id<REDAuthorDataAccessObject> authorDataAccessObject;
@property (setter=injected2:) id<REDBookRepositoryFactory> bookRepositoryFactory;

@end

@implementation REDAuthorRemoverImpl

#pragma mark - remove
-(void)removeAuthor:(id<REDAuthorProtocol>)author withCallback:(void (^)())callback {
    self.callback = callback;
    self.author = author;
    [[[UIAlertView alloc] initWithTitle:@"Careful!" message:@"By deleting the author, all books written by this author will be removed from the library!" delegate:self cancelButtonTitle:@"NO WAY!" otherButtonTitles:@"Ok", nil] show];
}

#pragma mark - alert view delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
    } else {
        for (id<REDBookProtocol> book in [self.author books]) {
            [[self.bookRepositoryFactory repository] removeForUser:self.user book:book callback:^{
                
            } error:^(NSError *error) {
                
            }];
        }
        [self.authorDataAccessObject remove:self.author];
        if (self.callback) self.callback();
    }
}

@end
