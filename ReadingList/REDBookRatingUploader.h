//
//  REDBookRatingUploader.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDBookUploaderProtocol.h"

@interface REDBookRatingUploader : NSObject

<REDBookUploaderProtocol>

#pragma mark - singleton
+(REDBookRatingUploader *)sharedUploader;

@end
