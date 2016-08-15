//
//  REDShareProgressValidator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 8/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDShareProgressValidator.h"
#import "REDBookProtocol.h"

@implementation REDShareProgressValidator

-(BOOL)validate:(id)obj error:(NSError *__autoreleasing *)error {
    id<REDBookProtocol> book = (id<REDBookProtocol>)obj;
    if ([book name].length == 0 || [book name] == nil) {
        return NO;
    }
    
    if ([book pagesValue] == 0) {
        return NO;
    }
    
    return YES;
}

@end
