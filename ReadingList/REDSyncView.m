//
//  REDSyncView.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDSyncView.h"

@interface REDSyncView ()

@end

@implementation REDSyncView

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        
    } return self;
}

#pragma mark - actions
-(IBAction)syncAction:(id)sender {
    [self.delegate syncViewWantsToAuthenticateWithView:self];
}

@end
