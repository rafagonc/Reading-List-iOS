//
//  REDImageSearchCollectionViewDatasourceDelegate.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/17/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol REDImageSearchCollectionViewDatasourceDelegate <NSObject>

-(void)datasource:(id<REDCollectionViewDatasourceProtocol>)datasource didSelectImage:(UIImage *)image error:(NSError *)error;

@end
