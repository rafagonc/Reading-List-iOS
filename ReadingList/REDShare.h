//
//  DYPShare.h
//  Picfind
//
//  Created by Rafael Gonzalves on 3/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol REDShare <NSObject>

-(void)share:(UIImage *)image with:(NSString *)text from:(UIViewController *)vc;

@end
