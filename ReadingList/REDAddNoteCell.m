//
//  REDAddNoteCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/19/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDAddNoteCell.h"

@implementation REDAddNoteCell

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } return self;
}

#pragma mark - events
-(void)selected {
    [self.delegate addNoteCellWantsToAddNote:self];
}

@end
