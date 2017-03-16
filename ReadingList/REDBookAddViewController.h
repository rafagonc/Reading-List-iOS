//
//  REDBookAddViewController.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDBookProtocol.h"

@interface REDBookAddViewController : UIViewController

#pragma mark - constructor
-(instancetype)init;
-(instancetype)initWithBook:(id<REDBookProtocol>)book;

@end
