//
//  REDPagesReadCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/27/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDPagesReadCell.h"
#import "UITextField+DoneButton.h"
#import "NSString+Digits.h"
#import "REDValidator.h"

@interface REDPagesReadCell ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITextField *pagesTextField;

#pragma mark - injected
@property (setter=injected_pages:,readonly) id<REDValidator> pagesValidator;

@end

@implementation REDPagesReadCell

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self = [super init]) {
        
    }return self;
}

#pragma mark - overrides
-(void)awakeFromNib {
    [super awakeFromNib];
    [self.pagesTextField addToolbar];
}

#pragma mark - chain
-(BOOL)process:(id<REDReadProtocol>)read error:(NSError *__autoreleasing *)error {
    if (![self.pagesValidator validate:self.pagesTextField.text error:error]) return NO;
    [read setPagesValue:[self.pagesTextField.text integerValue]];
    return YES;
}

@end
