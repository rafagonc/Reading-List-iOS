//
//  REDNewOptionsViewController.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "PopoverViewController.h"

typedef enum : NSInteger {
    REDNewOptionsNewBook,
    REDNewOptionsNewLog,
} REDNewOptions;

typedef void(^REDNewOptionsViewControllerCallback)(REDNewOptions option);

@interface REDNewOptionsViewController : PopoverViewController

#pragma mark - creation callback
-(void)whatToCreateCallback:(REDNewOptionsViewControllerCallback)callback;

@end
