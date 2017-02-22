//
//  REDBookCoverInlineView.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDBookCoverInlineView.h"
#import "UIImageView+WebCache.h"

@interface REDBookCoverInlineView ()

#pragma mark - properties
@property (nonatomic,strong) NSMutableArray<UIImageView *> * coverImageViews;
@property (nonatomic,strong) NSMutableArray<NSString *> * urls;

@end

@implementation REDBookCoverInlineView

#pragma mark - constructor
-(instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    } return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    } return self;
}
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    } return self;
}
-(void)commonInit {
    self.coverImageViews = [@[] mutableCopy];
    self.urls = [@[] mutableCopy];
}

#pragma mark - layout
-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self.coverImageViews enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj sd_setImageWithURL:[NSURL URLWithString:[self.urls objectAtIndex:idx]]];
        [obj setFrame:CGRectMake((self.frame.size.height/2 + 12) * idx, 0, self.frame.size.height/2 + 5, self.frame.size.height)];
    }];
}

#pragma mark - adding
-(void)addURL:(NSString *)url {    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.tag = [_urls indexOfObject:url];
    [self addSubview:imageView];
    [self.coverImageViews addObject:imageView];
}
-(void)setUrls:(NSMutableArray<NSString *> *)urls {
    _urls = nil;
    for (UIView * subview in self.subviews) {
        [subview removeFromSuperview];
    }
    [self.coverImageViews removeAllObjects];
    
    _urls = urls;
    for (NSString * url in urls) {
        [self addURL:url];
    }
    
    [self setNeedsLayout];
}

@end
