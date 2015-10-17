//
//  REDDictionary2ModelFactoryProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol REDDictionary2ModelFactoryProtocol <NSObject>

@property (nonatomic,strong) NSArray *input;
-(NSArray *)outputForMany;

@end
