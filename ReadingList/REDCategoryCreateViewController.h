//
//  REDCategoryCreateViewController.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 8/13/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDCategoryProtocol.h"

typedef void(^REDCategoryCreateViewControllerCallback)(id<REDCategoryProtocol> category);

@interface REDCategoryCreateViewController : UIViewController

#pragma mark  - constructor
-(instancetype)initWithCategory:(id<REDCategoryProtocol>)author;

#pragma mark - properties
@property (nonatomic,copy) REDCategoryCreateViewControllerCallback calback;

@end
