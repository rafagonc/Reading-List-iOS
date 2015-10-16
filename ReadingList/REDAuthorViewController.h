//
//  REDAuthorViewController.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/15/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDAuthorProtocol.h"

typedef void(^REDAuthorViewControllerCallback)(id<REDAuthorProtocol> author);

@interface REDAuthorViewController : UIViewController

@property (nonatomic,copy) REDAuthorViewControllerCallback callback;

@end
