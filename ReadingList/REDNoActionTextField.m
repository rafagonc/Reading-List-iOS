//
//  REDNoActionTextField.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/17/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDNoActionTextField.h"

@implementation REDNoActionTextField

#pragma mark - override
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

@end
