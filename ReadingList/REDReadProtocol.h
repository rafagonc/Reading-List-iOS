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

@property (nonatomic) NSInteger identifier;
@property (nonatomic,strong) NSDate * date;
@property (nonatomic,assign) NSInteger pagesValue;
@property (nonatomic) NSString *   uuid;

#pragma mark - relationships
-(void)setBook:(id<REDBookProtocol>)book;
-(id<REDBookProtocol>)book;

@end
