//
//  REDRLMAuthor.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMAuthor.h"

@implementation REDRLMAuthor

-(NSArray *)books {
    return [self linkingObjectsOfClass:@"REDBook" forProperty:@"author"];
}

@end
