//
//  REDAuthorRemover.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 7/7/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDAuthorProtocol.h"

@protocol REDAuthorRemover <NSObject>

-(void)removeAuthor:(id<REDAuthorProtocol>)author withCallback:(void(^)())callback;

@end
