//
//  REDAddViewController.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 12/21/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarReaderViewController.h"

@interface REDAddViewController : UIViewController

#pragma mark - constructor
-(instancetype)init UNAVAILABLE_ATTRIBUTE;
-(instancetype)initWithDelegate:(id<ZBarReaderDelegate>)zbarDelegate;

@end
