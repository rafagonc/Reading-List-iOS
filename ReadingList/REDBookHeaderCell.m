//
//  REDBookHeaderCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookHeaderCell.h"
#import "UITextField+DoneButton.h"


@implementation REDBookHeaderCell

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        [self.nameTextField addToolbar];
    } return self;
}

#pragma mark - setters
-(void)setBook:(id<REDBookProtocol>)book {
    _book = book;
    [self.coverButton setBackgroundImage:[book cover] forState:UIControlStateNormal];
    [self.nameTextField setText:[book name]];
}
-(void)setAuthor:(id<REDAuthorProtocol>)author {
    _author = author;
    [self.authorButton setTitle:[author name] forState:UIControlStateNormal];
    [self.authorButton setTitleColor:author ? [UIColor darkTextColor] : [UIColor lightGrayColor] forState:UIControlStateNormal];
}

#pragma mark - chain of responsiblity
-(BOOL)setNewValuesOnBook:(id<REDBookProtocol>)book error:(NSError *__autoreleasing *)error {
    if (self.nameTextField.text.length == 0) {
        *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey: @"Choose a book name."}];
        return NO;
    }
    if (self.author == nil) {
        *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey: @"Choose an author."}];
        return NO;
    }
    [book setName:self.nameTextField.text];
    
    return YES;
}

#pragma mark - actions
-(IBAction)authorAction:(id)sender {
    [self.delegate didSelectAuthorInBookHeaderCell:self];
}
-(IBAction)coverAction:(id)sender {
    [self.delegate didSelectCoverInBookHeaderCell:self];
}
@end
