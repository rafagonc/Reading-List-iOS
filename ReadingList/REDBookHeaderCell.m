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
        [self.authorTextField addToolbar];
    } return self;
}

#pragma mark - setters
-(void)setBook:(id<REDBookProtocol>)book {
    _book = book;
    [self.coverButton setBackgroundImage:[book cover] forState:UIControlStateNormal];
    [self.nameTextField setText:[book name]];
    [self.authorTextField setText:[[book artist] name]];
}

#pragma mark - chain of responsiblity
-(void)setNewValuesOnBook:(id<REDBookProtocol>)book error:(NSError *__autoreleasing *)error {
    [book setName:self.nameTextField.text];

}

@end
