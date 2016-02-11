//
//  REDRLMArrayHelper.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/4/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@protocol REDRLMArrayHelper <NSObject>

-(NSArray *)arrayFromResults:(RLMResults *)results;

@end
