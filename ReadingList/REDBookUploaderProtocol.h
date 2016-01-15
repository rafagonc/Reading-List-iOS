//
//  REDBookUploaderProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDBookProtocol.h"

@protocol REDBookUploaderProtocol <NSObject>

-(void)uploadBook:(id<REDBookProtocol>)book forRating:(CGFloat)rating;

@end
