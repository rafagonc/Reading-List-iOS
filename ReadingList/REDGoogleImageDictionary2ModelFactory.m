//
//  REDGoogleImageDictionary2ModelFactory.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDGoogleImageDictionary2ModelFactory.h"
#import "REDDictionary2ModelFactory_Protected.h"
#import "REDGoogleSearchImageResult.h"

@implementation REDGoogleImageDictionary2ModelFactory

-(id)parse:(NSDictionary *)dict {
    return [[REDGoogleSearchImageResult alloc] initWithDictionary:dict];
}

@end
