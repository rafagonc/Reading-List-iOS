//
//  REDRequestFeature.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol REDRequestFeature <NSObject>

-(void)request:(UIViewController *)vc;

@end