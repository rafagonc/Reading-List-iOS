//
//  REDCategoryRemover.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 8/16/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDCategoryRemoverImpl.h"
#import "REDCategoryDataAccessObject.h"
#import "REDBookRepositoryFactory.h"
#import "REDUserProtocol.h"

@interface REDCategoryRemoverImpl ()

#pragma mark - properties
@property (nonatomic,strong) id<REDCategoryProtocol> category;
@property (nonatomic,copy) void (^callback)();

#pragma mark - injected
@property (setter=injected1:) id<REDCategoryDataAccessObject> categoryDataAccessObject;
@property (setter=injected2:) id<REDBookRepositoryFactory> bookRepositoryFactory;
@property (setter=injected3:) id<REDUserProtocol> user;

@end

@implementation REDCategoryRemoverImpl

-(void)removeCategory:(id<REDCategoryProtocol>)category withCallback:(void (^)())callback {
    self.callback = callback;
    self.category = category;
    [[[UIAlertView alloc] initWithTitle:@"Careful!" message:@"By deleting the category, all books related to this category will be removed from the library!" delegate:self cancelButtonTitle:@"NO WAY!" otherButtonTitles:@"Ok", nil] show];
}

#pragma mark - alert view delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
    } else {
        for (id<REDBookProtocol> book in [self.category books]) {
            [[self.bookRepositoryFactory repository] removeForUser:self.user book:book callback:^{} error:^(NSError *error) {}];
        }
        [self.categoryDataAccessObject remove:self.category];
        if (self.callback) self.callback();
    }
}

@end
