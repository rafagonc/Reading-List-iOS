//
//  UISearchBar+Toolbar.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/17/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UISearchBarDoneCallback)();

@interface UISearchBar (Toolbar)

-(void)addToolbar;
-(void)addToolbarWithCallback:(UISearchBarDoneCallback)callback;

@end
