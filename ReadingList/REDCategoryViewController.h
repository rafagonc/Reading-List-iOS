//
//  REDCategoryViewController.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/14/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDCategoryProtocol.h"

typedef void(^REDCategoryViewControllerCallback)(id<REDCategoryProtocol> category);

@interface REDCategoryViewController : UIViewController

@property (nonatomic,copy) REDCategoryViewControllerCallback callback;

@end
