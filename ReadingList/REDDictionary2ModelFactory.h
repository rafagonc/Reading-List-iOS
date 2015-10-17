//
//  REDDictionary2ModelFactory.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDDictionary2ModelFactoryProtocol.h"

@interface REDDictionary2ModelFactory : NSObject

<REDDictionary2ModelFactoryProtocol>

#pragma mark - factory method
+(NSArray *)outputForMany:(NSArray *)input;

@end
