//
//  REDNoteCellTableViewCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/19/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDNoteCell.h"
#import "UITextView+Done.h"
#import "REDNoteRepositoryFactory.h"
#import "REDNoteRepository.h"
#import "REDUserProtocol.h"
#import "REDTransactionManager.h"

@interface REDNoteCell () <UITextViewDelegate>

#pragma mark - properties
@property (strong, nonatomic) id<REDNotesProtocol> note;
@property (strong, nonatomic) id<REDNoteRepository> noteRepository;

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITextView *textView;

#pragma mark - injected
@property (setter=injected1:) id<REDNoteRepositoryFactory> noteRepositoryFactory;
@property (setter=injected2:) id<REDUserProtocol> user;
@property (setter=injected3:) id<REDTransactionManager> transactionManager;

@end

@implementation REDNoteCell

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        self.textView.delegate = self;
        [self.textView addToolbar];
    } return self;
}

#pragma mark - setters
-(void)setNote:(id<REDNotesProtocol>)note {
    _note = note;
    self.textView.text = [note text];
}

#pragma mark - actions
-(IBAction)trashAction:(id)sender {
    [self.delegate noteCell:self wantsToDeleteNote:self.note];
}

#pragma mark - height
-(CGFloat)height {
    return MAX([self.textView.text boundingRectWithSize:CGSizeMake(self.textView.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.textView.font} context:nil].size.height + 22, 44);
}

#pragma mark - delegate
-(void)textViewDidEndEditing:(UITextView *)textView {
    [self.transactionManager begin];
    [self.note setText:textView.text];
    [self.transactionManager commit];
    if (textView.text.length) {
        self.noteRepository = [self.noteRepositoryFactory repository];
        [self.noteRepository updateForUser:self.user note:self.note callback:^(id<REDNotesProtocol> note) {
            
        } error:^(NSError *error) {
            
        }];
    } else {
        [self.delegate noteCell:self wantsToDeleteNote:self.note];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    [self.delegate noteCell:self didUpdateNote:self.note];
    return YES;
}

#pragma mark - override
-(BOOL)resignFirstResponder {
    [super resignFirstResponder];
    [self.textView resignFirstResponder];
    return YES;
}

#pragma mark - selected
-(void)selected {
    [self.delegate noteCell:self wantsToOpenNote:self.note];
}

@end
