//
//  PleaseRateViewController.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "PopoverViewController.h"
#import "REDBookProtocol.h"

@interface REDPleaseRateViewController : PopoverViewController

#pragma mark - constructor
-(instancetype)initWithBook:(id<REDBookProtocol>)book;

@end
