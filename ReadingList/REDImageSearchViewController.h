//
//  REDImageSearchViewController.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^REDImageSearchViewControllerCallback)(UIImage *image);

@interface REDImageSearchViewController : UIViewController

#pragma mark - cosntructor
-(instancetype)initWithBookName:(NSString *)bookName andAuthor:(NSString *)author;

#pragma mark - callback
@property (copy) REDImageSearchViewControllerCallback callback;

@end
