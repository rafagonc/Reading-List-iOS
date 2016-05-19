//
//  REDSyncLogRepository.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/6/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDLogRepository.h"

@interface REDSyncLogRepository : NSObject

<REDLogRepository>

#pragma mark - singleton
+(REDSyncLogRepository *)sharedRepository;

@end
