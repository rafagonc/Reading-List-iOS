//
//  REDCategoryRemover.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 8/16/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDCategoryProtocol.h"

@protocol REDCategoryRemover <NSObject>

-(void)removeCategory:(id<REDCategoryProtocol>)category withCallback:(void(^)())callback;

@end
