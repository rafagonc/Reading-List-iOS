//
//  REDReadProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDBookProtocol.h"

@protocol REDReadProtocol <NSObject>

@property (nonatomic,strong) NSDate * date;
@property (nonatomic,assign) NSInteger pagesValue;
@property (nonatomic,strong) id<REDBookProtocol> book;

@end
