//
//  REDGoodReadsBook.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDBookProtocol.h"

@interface REDTransientBook : NSObject

<REDBookProtocol>

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *authorsName;
@property (nonatomic,strong) NSString *imageURL;
@property (nonatomic,strong) UIImage *coverImage;


@end
