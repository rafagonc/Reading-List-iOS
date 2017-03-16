//
//  REDAuthorCreateViewController.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/15/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDAuthorProtocol.h"

typedef void(^REDAuthorCreateViewControllerCallback)(id<REDAuthorProtocol> author);

@interface REDAuthorCreateViewController : UIViewController

#pragma mark  - constructor
-(instancetype)initWithAuthor:(id<REDAuthorProtocol>)author;

#pragma mark - callback
@property (nonatomic,copy) REDAuthorCreateViewControllerCallback callback;

@end
