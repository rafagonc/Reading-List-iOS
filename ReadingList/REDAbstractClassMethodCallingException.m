//
//  REDAbstractClassMethodCallingException.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDAbstractClassMethodCallingException.h"

@implementation REDAbstractClassMethodCallingException

+(NSException *)raise {
    return [NSException exceptionWithName:@"REDAbstractClassMethodCallingException" reason:@"This class is abstract" userInfo:@{}];
}

@end
