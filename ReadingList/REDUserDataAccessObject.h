//
//  REDUserDataAccessObject.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/27/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDDataAccessObject.h"
#import "REDUserProtocol.h"

@protocol REDUserDataAccessObject <REDDataAccessObject>

-(id<REDUserProtocol>)user;

@end
