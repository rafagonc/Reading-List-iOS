//
//  REDChooseBookViewController.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/27/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDBookProtocol.h"

@class REDChooseBookViewController;
@protocol REDChooseBookViewControllerDelegate <NSObject>

-(void)chooseBookViewController:(REDChooseBookViewController *)chooseBookViewController justChoseBook:(id<REDBookProtocol>)book;

@end

@interface REDChooseBookViewController : UIViewController

@property (nonatomic,weak) id<REDChooseBookViewControllerDelegate> delegate;

@end
