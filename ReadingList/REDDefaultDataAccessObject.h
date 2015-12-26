//
//  REDDefaultDataAccessObject.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "REDDataAccessObject.h"

@interface REDDefaultDataAccessObject : NSObject

<REDDataAccessObject>

@property (nonatomic,assign) BOOL cloudEnabled;

@end
