//
//  REDDatasourceProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol REDDatasourceProtocol <UITableViewDelegate, UITableViewDataSource>

#pragma mark - properties
@property (nonatomic,copy) id data;
@property (nonatomic,weak) id delegate;

@end
