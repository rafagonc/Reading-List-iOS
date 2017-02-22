//
//  REDPageProgressCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDPageProgressCell.h"
#import <Crashlytics/Answers.h>
#import "HCSStarRatingView.h"
#import "UIColor+ReadingList.h"
#import "UITextField+DoneButton.h"
#import "REDValidator.h"

@interface REDPageProgressCell () <UITextFieldDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UILabel *currentPageLabel;
@property (weak, nonatomic) IBOutlet UITextField *currentPageTextField;
@property (weak, nonatomic) IBOutlet UISlider *slider;

#pragma mark - injected
@property (setter=injected_pages:) id<REDValidator> pagesValidator;

#pragma mark - properties
@property (nonatomic,assign) NSUInteger pagedReadInitialValue;


@end

@implementation REDPageProgressCell

#pragma mark - construcotr
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.slider addTarget:self action:@selector(sliderEditEnd:) forControlEvents:UIControlEventTouchUpInside];
        self.currentPageTextField.delegate = self;
        [self.currentPageTextField addToolbar];
        
    } return self;
}

#pragma mark - setters
-(void)setBook:(id<REDBookProtocol>)book {
    _book = book;
    self.pages = [book pagesValue];
    self.pagesRead = [book pagesReadValue];
    self.pagedReadInitialValue = [book pagesReadValue];
    self.slider.minimumValue = 0.0f;
    self.slider.maximumValue = self.pages;
    self.slider.value = (CGFloat)[book pagesReadValue];
    [self updateProgressLabel];
}
-(void)setPages:(NSUInteger)pages {
    _pages = pages;
    self.slider.maximumValue = (CGFloat)self.pages;
}

#pragma mark - actions
-(void)sliderValueChanged:(UISlider *)slider {
    [self updateProgressLabel];
}
-(void)sliderEditEnd:(UISlider *)slider {
    if ((NSUInteger)slider.value - (NSUInteger)self.pagedReadInitialValue > 0)
    self.diff = (NSUInteger)slider.value - (NSUInteger)self.pagedReadInitialValue;
    [self setPagesRead:slider.value];
    if (self.pagesRead == self.pages && self.pages > 0) {
        [self.delegate pageProgressCell:self didCompleteBookReading:self.book];
    }
}

#pragma mark - text field delegate
-(void)textFieldDidEndEditing:(UITextField *)textField {
    NSError *error;
    if (![self.pagesValidator validate:textField.text error:&error]) {
        return;
    }
    self.pagesRead = [textField.text integerValue];
    [self.slider setValue:self.pagesRead animated:YES];
    self.diff = (NSUInteger)self.slider.value - (NSUInteger)self.pagedReadInitialValue;
    [self updateProgressLabel];
}

#pragma mark - chain of responsiblity
-(BOOL)setNewValuesOnBook:(id<REDBookProtocol>)book error:(NSError *__autoreleasing *)error {
    [book setPagesReadValue:self.pagesRead];
    if (self.pages == self.pagesRead) {
        [Answers logContentViewWithName:@"Book"
                            contentType:@"Completed"
                              contentId:@""
                       customAttributes:@{}];
    }
    
    
    return YES;
}

#pragma makr - selected
-(void)selected {
    if (self.pages == 0) {
        [self.delegate pageProgressCell:self tryingToSetPagesWhileIsZeroForBook:self.book];
    }
}

#pragma mark - helper methods
-(void)updateProgressLabel {
    self.currentPageTextField.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.slider.value];
}


@end
