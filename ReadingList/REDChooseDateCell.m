//
//  REDChooseDateCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/27/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDChooseDateCell.h"
#import "UITextField+DoneButton.h"
#import "REDValidator.h"

@interface REDChooseDateCell ()
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

#pragma mark - injected
@property (setter=injected_date:,readonly) id<REDValidator> dateValidator;

@end

@implementation REDChooseDateCell

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self = [super init]) {
        
    } return self;
}

#pragma mark - overrides
-(void)awakeFromNib {
    [super awakeFromNib];
    self.dateTextField.inputView = self.datePicker;
    [self.dateTextField addToolbar];
}

#pragma mark - chain
-(BOOL)process:(id<REDReadProtocol>)read error:(NSError *__autoreleasing *)error {
    if (![self.dateValidator validate:self.datePicker.date error:error]) return NO;
    [read setDate:self.datePicker.date];
    return YES;
}

@end
