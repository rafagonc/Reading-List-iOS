//
//  REDTutorialChainOfResponsibility.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDTutorialViewController.h"

@protocol REDTutorialChainOfResponsibilityProtocol <NSObject>

-(BOOL)process:(REDTutorialViewController *)tutorial error:(NSError **)error;

@end
