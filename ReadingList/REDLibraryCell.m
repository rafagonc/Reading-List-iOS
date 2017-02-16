//
//  REDLibraryCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/16/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLibraryCell.h"
#import "REDLibraryView.h"

@interface REDLibraryCell () <REDLibraryViewDelegate>

@property (nonatomic,assign) CGFloat cellHeight;

@end

@implementation REDLibraryCell

#pragma mark - constructor
-(instancetype)init {
    self = [super init];
    if (self) {
        
        REDLibraryView * libraryView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([REDLibraryView class]) owner:self options:nil] firstObject];
        [self.contentView addSubview:libraryView];
        [self setLibraryView:libraryView];
        [self.libraryView setDelegate:self];
        
    } return self;
}

#pragma mark - layout
-(void)layoutSubviews {
    [super layoutSubviews];
    self.libraryView.frame = self.contentView.frame;
}

#pragma mark - delegate
-(void)libraryViewDidUpdate:(REDLibraryView *)libraryView {
    self.cellHeight = [[libraryView.datasource data] count] * REDBookCellHeight;
    [self.delegate libraryCellDidUpdate:self];
}

#pragma mark - setters
-(void)setEditing:(BOOL)editing {
    
}

#pragma mark - height 
-(CGFloat)height {
    return self.libraryView.tableView.contentSize.height ;
}


@end
