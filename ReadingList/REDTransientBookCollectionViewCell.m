//
//  REDTransientBookCollectionViewCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDTransientBookCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIColor+ReadingList.h"

@interface REDTransientBookCollectionViewCell ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) UIView *redView;

@end

@implementation REDTransientBookCollectionViewCell

-(void)setBook:(REDTransientBook *)book {
    _book = book;
    self.bookName.text = [book name];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[book imageURL]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            
        }
    }];
}

-(void)setAdded:(BOOL)added {
    _added = added;
    if (added) {
        [self.redView removeFromSuperview];
        self.redView = nil;
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 10)];
        [view.layer setBorderColor:[UIColor red_redColor].CGColor];
        [view.layer setBorderWidth:3];
        [view.layer setCornerRadius:8];
        [view setBackgroundColor:[[UIColor red_redColor] colorWithAlphaComponent:0.3]];
        [self.contentView addSubview:view];
        [self setRedView:view];
    } else {
        [self.redView removeFromSuperview];
        self.redView = nil;
    }
}

@end
