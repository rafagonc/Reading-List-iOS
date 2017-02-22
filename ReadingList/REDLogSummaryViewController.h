//
//  REDLogSummaryViewController.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 2/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDReadProtocol.h"

@interface REDLogSummaryViewController : UIViewController

#pragma mark - constructor
-(instancetype)initWithLogs:(NSArray <id<REDReadProtocol>> *)reads andDate:(NSDate *)date;

@end
