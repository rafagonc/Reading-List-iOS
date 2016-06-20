//
//  REDNoteCellTableViewCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/19/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDNoteCell.h"

@interface REDNoteCell ()
@property (strong, nonatomic) id<REDNotesProtocol> note;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation REDNoteCell

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        
    } return self;
}

#pragma mark - setters
-(void)setNote:(id<REDNotesProtocol>)note {
    _note = note;
    self.label.text = [note text];
}

#pragma mark - actions
-(IBAction)trashAction:(id)sender {
    [self.delegate noteCell:self wantsToDeleteNote:self.note];
}

#pragma mark - selected
-(void)selected {
    [self.delegate noteCell:self wantsToOpenNote:self.note];
}

@end
