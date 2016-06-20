//
//  REDAddNoteViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/19/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDAddNoteViewController.h"
#import "UITextView+Done.h"
#import "REDBookDataAccessObject.h"
#import "REDNotesProtocol.h"
#import "REDTransactionManager.h"

@interface REDAddNoteViewController () <UITextViewDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *createButton;

#pragma mark - properties
@property (nonatomic,weak) id<REDBookProtocol> book;
@property (nonatomic,strong, nullable) id<REDNotesProtocol> note;

#pragma mark - injected
@property (setter=injected1:) id<REDTransactionManager> transactionManager;
@property (setter=injected2:) id<REDBookDataAccessObject> bookDataAccessObject;

@end

@implementation REDAddNoteViewController

#pragma mark - constructor
-(instancetype)initWithBook:(id<REDBookProtocol>)book {
    if (self = [super initWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width * .8f, 250)]) {
        self.book = book;
    } return self;
}
-(instancetype)initWithBook:(id<REDBookProtocol>)book andNote:(id<REDNotesProtocol>)notesx {
    if (self = [super initWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width * .8f, 250)]) {
        self.book = book;
        self.note = notesx;
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.cornerRadius = 12;
    
    [self.textView setText:[self.note text]];
    [self.textView addToolbar];
    [self.textView setDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardUp:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDown:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

#pragma mark - actions
-(IBAction)createAction:(id)sender {
    if (self.note ) {
        if (self.textView.text.length > 2) {
            [self.transactionManager begin];
            [self.note setText:self.textView.text];
            [self.transactionManager commit];
        }
    } else {
        if (self.textView.text.length > 2) {
            [self.delegate addNoteViewController:self didJustAddNote:[self.bookDataAccessObject createNote:self.textView.text forBook:self.book]];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - text view delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView.text.length > 1) {
        [self.createButton setTitle:self.note ? @"Edit" : @"Create" forState:UIControlStateNormal];
    } else {
        [self.createButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    }
    return YES;
}

#pragma mark - keyboard evetns
-(void)keyboardUp:(NSNotification *)notification {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 150, self.view.frame.size.width, self.view.frame.size.height);
        self.insets = UIEdgeInsetsMake(0, 0, 150, 0);
    }];
}
-(void)keyboardDown:(NSNotification *)notification {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 150, self.view.frame.size.width, self.view.frame.size.height);
        self.insets = UIEdgeInsetsMake(0, 0, 0, 0);
    }];
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
