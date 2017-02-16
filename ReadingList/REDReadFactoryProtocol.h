//
//  REDReadFactoryProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDBookProtocol.h"

@protocol REDReadFactoryProtocol <NSObject>

-(void)createReadWithPageDiff:(NSInteger)page_diff forBook:(id<REDBookProtocol>)book;

@end
