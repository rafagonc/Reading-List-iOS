
//
//  REDCollectionViewDatasourceProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol REDCollectionViewDatasourceProtocol <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong) NSArray *data;

@property (nonatomic, weak) id delegate;

@end
