//
//  REDBookPredicateViewController.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/10/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface REDBookPredicateViewController : UIViewController

#pragma mark - constructor
-(instancetype)initWithPrediate:(NSPredicate *)predicate;

#pragma mark - setters
-(void)setNavigationBarTitle:(NSString *)title;

@end
