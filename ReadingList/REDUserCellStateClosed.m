//
//  REDUserCellStateClosed.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDUserCellStateClosed.h"

@interface REDUserCellStateClosed ()

@end

@implementation REDUserCellStateClosed

@synthesize delegate;

-(void)populateScrollView:(UIScrollView *)scrollView andCallback:(void (^)(CGSize))callback {
    UIView * chartView = [scrollView viewWithTag:REDUserCellChartViewTag];
    [chartView removeFromSuperview];
    
    UIView * syncView = [scrollView viewWithTag:REDUserCellSyncViewTag];
    [syncView removeFromSuperview];
    
    UIView * pagesView = [scrollView viewWithTag:REDUserCellPagesInfoViewTag];
    [pagesView removeFromSuperview];
}
-(BOOL)hidePageControl {
    return YES;
}

@end
