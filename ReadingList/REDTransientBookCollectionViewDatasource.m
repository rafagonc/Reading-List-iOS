//
//  REDTransientBookCollectionViewDatasource.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDTransientBookCollectionViewDatasource.h"
#import "REDTransientBook.h"
#import "UIFont+ReadingList.h"
#import "REDTransientBookCollectionViewCell.h"
#import "REDTransientBookCompletedAdapter.h"
#import "REDTransientBookCollectionViewDelegate.h"

@interface REDTransientBookCollectionViewDatasource ()

@property (nonatomic,strong) NSArray <REDTransientBookCompletedAdapter *> * transientBook;

@end

@implementation REDTransientBookCollectionViewDatasource

@synthesize delegate;

#pragma mark - setter
-(void)setData:(NSArray *)data {
    self.transientBook = data;
}
-(NSArray *)data {
    return self.transientBook;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.transientBook count];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(108, 108 + MIN([[[[self.transientBook objectAtIndex:indexPath.row] book] name] boundingRectWithSize:CGSizeMake(108 - 40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont AvenirNextRegularWithSize:17.0f]} context:nil].size.height, 80) + 20);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellId = NSStringFromClass([REDTransientBookCollectionViewCell class]);
    REDTransientBookCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([REDTransientBookCollectionViewCell class]) owner:self options:nil] firstObject];
    }
    cell.book = [[self.transientBook objectAtIndex:indexPath.row] book];
    [cell setAdded:[[self.transientBook objectAtIndex:indexPath.row] added]];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [[self.transientBook objectAtIndex:indexPath.row]setAdded:![[self.transientBook objectAtIndex:indexPath.row] added]];
    REDTransientBookCollectionViewCell * cell = (REDTransientBookCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    [cell setAdded:[[self.transientBook objectAtIndex:indexPath.row] added]];
    [collectionView reloadData];
    if ([[self.transientBook objectAtIndex:indexPath.row] added]) {
        [self.delegate transientBookDatasource:self justRemovedBook:[[self.transientBook objectAtIndex:indexPath.row] book]];
    } else {
        [self.delegate transientBookDatasource:self justAddedBook:[[self.transientBook objectAtIndex:indexPath.row] book]];
    }
}

@end
