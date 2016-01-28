//
//  REDUserViewDelegate.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/26/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@class REDUserView;
@protocol REDUserViewDelegate <NSObject>

-(void)userViewWantsToSelectProfilePhoto:(REDUserView *)userView;

@end
