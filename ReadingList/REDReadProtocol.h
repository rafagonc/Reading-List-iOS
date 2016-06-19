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
@property (nonatomic,strong, nonnull) NSDate * date;
@property (nonatomic,assign) NSInteger pagesValue;
@property (nonatomic,nonnull) NSString *   uuid;

#pragma mark - relationships
-(void)setBook:(_Nonnull id<REDBookProtocol>)book;
-(_Nullable id<REDBookProtocol>)book;

@end
