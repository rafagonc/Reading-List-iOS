//
//  REDAllSetViewController.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDAllSetViewControllerDelegate.h"

@interface REDAllSetViewController : UIViewController

#pragma mark - constructor
-(instancetype)initWithDelegate:(id<REDAllSetViewControllerDelegate>)delegate;

#pragma mark  - properties
@property (nonatomic,weak) id<REDAllSetViewControllerDelegate> delegate;

@end
