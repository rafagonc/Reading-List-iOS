//
//  REDUserView.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDUserView.h"
#import "REDUserProtocol.h"
#import "UITextField+DoneButton.h"
#import "REDDataStack.h"
#import "REDTransactionManager.h"
#import "REDBookDataAccessObject.h"

@interface REDUserView () <UITextFieldDelegate>

#pragma mark - injected
@property (setter=injected:,readonly) id<REDTransactionManager> transactionManager;
@property (setter=injected:,readonly) id<REDBookDataAccessObject> bookDataAccessObject;


#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *booksLabel;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;

@end

@implementation REDUserView

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        
    } return self;
}

#pragma mark - overrides
-(void)awakeFromNib {
    [super awakeFromNib];
    [self.nameTextField addToolbar];
    self.nameTextField.delegate = self;
    self.booksLabel.text = [self.bookDataAccessObject booksCompletedAndTotalBooks];
}

#pragma mark - layout
-(void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - setters
-(void)setUser:(id<REDUserProtocol>)user {
    _user = user;
    self.nameTextField.text = [user hasName] ? [self.user name] : @"Your Name";
    if ([user hasPhoto]) [self.photoButton setBackgroundImage:[user photo] forState:UIControlStateNormal];
    else [self.photoButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.photoButton setTitle:[user hasPhoto] ? @"" : @"photo" forState:UIControlStateNormal];
}

#pragma mark - text field delegate
-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.transactionManager begin];
    [self.user setName:textField.text];
    [self.transactionManager commit];
}

#pragma mark - actions
-(IBAction)pickPhoto:(id)sender {
    [self.delegate userViewWantsToSelectProfilePhoto:self];
}

#pragma mark - dealloc
-(void)dealloc {
    
}

@end
