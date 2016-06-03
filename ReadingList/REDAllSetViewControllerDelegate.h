//
//  REDAllSetViewControllerDelegate.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
@class REDAllSetViewController;

@protocol REDAllSetViewControllerDelegate <NSObject>

-(void)controllerDidFinishTutorial:(REDAllSetViewController *)controller;

@end
