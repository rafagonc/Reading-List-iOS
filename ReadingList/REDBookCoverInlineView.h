//
//  REDBookCoverInlineView.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface REDBookCoverInlineView : UIView

#pragma mark - adding
-(void)addURL:(NSString *)url;
-(void)setUrls:(NSMutableArray<NSString *> *)urls;

@end
