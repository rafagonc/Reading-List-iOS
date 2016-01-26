//
//  REDReadFactory.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDReadFactory.h"
#import "REDReadDataAccessObject.h"
#import "REDReadProtocol.h"
#import "REDCloudDataStack.h"

@interface REDReadFactory ()

@property (setter=injected:,readonly) id<REDReadDataAccessObject> readDataAccessObject;

@end

@implementation REDReadFactory

-(void)createReadWithPageDiff:(NSInteger)page_diff forBook:(id<REDBookProtocol>)book {
    id<REDReadProtocol> newRead = [self.readDataAccessObject create];
    [newRead setDate:[NSDate date]];
    [newRead setBook:book];
    [newRead setPagesValue:page_diff];
}

@end
