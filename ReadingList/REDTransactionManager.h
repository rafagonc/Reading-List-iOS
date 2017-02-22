//
//  REDTransactionManager.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/4/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol REDTransactionManager <NSObject>

-(void)begin;
-(void)commit;

@end
