//
//  REDBookPagesCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookPagesCell.h"
#import "UITextField+DoneButton.h"
#import "NSString+Digits.h"

@interface REDBookPagesCell () <UITextFieldDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITextField *pagesTextField;

@end

@implementation REDBookPagesCell

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        [self.pagesTextField addToolbar];
        self.pagesTextField.delegate = self;
    } return self;
}

#pragma mark - setters
-(void)setPages:(NSUInteger)pages {
    _pages = pages;
    [self.pagesTextField setText:[NSString stringWithFormat:@"%lu",(unsigned long)pages]];
}

#pragma mark - chain of responsiblity
-(BOOL)setNewValuesOnBook:(id<REDBookProtocol>)book error:(NSError *__autoreleasing *)error {
    if (self.pagesTextField.text.length == 0) {
        *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Set the number of pages"}];
        return NO;
    } else if ([self.pagesTextField.text onlyDigits] == NO) {
        *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"The page number must be only digits"}];
        return NO;
    }
    [book setPages:[self.pagesTextField.text intValue]];
    return YES;
}

#pragma mark text field delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField.text onlyDigits]) {
        [self.delegate pagesCell:self didChangeBookPages:[textField.text integerValue]];
        
    }
    return YES;
}

@end

