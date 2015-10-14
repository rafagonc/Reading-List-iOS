//
//  REDBookPagesCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookPagesCell.h"
#import "UITextField+DoneButton.h"

@interface REDBookPagesCell ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITextField *pagesTextField;

@end

@implementation REDBookPagesCell

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        [self.pagesTextField addToolbar];
    } return self;
}

#pragma mark - setters
-(void)setPages:(NSUInteger)pages {
    _pages = pages;
    [self.pagesTextField setText:[NSString stringWithFormat:@"%lu",(unsigned long)pages]];
}

@end

