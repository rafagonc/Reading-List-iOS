//
//  REDBookRatingRequest.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRequestProtocol.h"
#import "REDBookProtocol.h"

@interface REDBookRatingRequest : NSObject

<REDRequestProtocol>

#pragma makr - constructor
-(instancetype)initWithBook:(id<REDBookProtocol>)book andRating:(CGFloat)rating;

#pragma mark - properties
@property (nonatomic,strong) id<REDBookProtocol> book;
@property (nonatomic,assign) CGFloat rating;

@end
