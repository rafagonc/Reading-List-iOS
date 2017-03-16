//
//  REDImageSearchCollectionViewDatasource.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDImageSearchCollectionViewDatasource.h"
#import "REDGoogleImageSearchCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "REDGoogleSearchImageResult.h"
#import "REDImageSearchCollectionViewDatasourceDelegate.h"

@interface REDImageSearchCollectionViewDatasource ()

#pragma mark - ui
@property (nonatomic,weak) UICollectionView * collection;

#pragma mark - properties
@property (nonatomic,strong) NSArray *googleImages;

@end

@implementation REDImageSearchCollectionViewDatasource

@synthesize delegate;

#pragma mark - getters and setters
-(void)setData:(NSArray *)data {
    _googleImages = data;
}
-(NSArray *)data {
    return _googleImages;
}
-(void)setCollection:(UICollectionView *)collection {
    _collection = collection;
    [_collection registerNib:[UINib nibWithNibName:NSStringFromClass([REDGoogleImageSearchCell class]) bundle:nil] forCellWithReuseIdentifier:@"REDGoogleImageSearchCell"];

}

#pragma mark - collection view
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    self.collection = collectionView;
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.googleImages.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"REDGoogleImageSearchCell";
    REDGoogleImageSearchCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    REDGoogleSearchImageResult *result = self.googleImages[indexPath.row];
    [cell.searchedImageView sd_setImageWithURL:[NSURL URLWithString:result.url]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    REDGoogleImageSearchCell *cell = (REDGoogleImageSearchCell *)[collectionView cellForItemAtIndexPath:indexPath];
    REDGoogleSearchImageResult *result = self.googleImages[indexPath.row];
    if (cell.searchedImageView.image) {
        [self.delegate datasource:self didSelectImage:cell.searchedImageView.image andURL:result.url error:nil];
    } else {
        [self.delegate datasource:self didSelectImage:nil andURL:nil error:[NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Wait for the image to load!"}]];
    }
}

@end
