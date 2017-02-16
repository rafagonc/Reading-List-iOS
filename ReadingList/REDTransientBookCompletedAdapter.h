//
//  REDTransientBookCompletedAdapter.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDTransientBook.h"

@interface REDTransientBookCompletedAdapter : NSObject

-(instancetype)initWithTransientBook:(REDTransientBook *)book;

@property (nonatomic,strong) REDTransientBook * book;
@property (nonatomic,assign) BOOL added;

@end
