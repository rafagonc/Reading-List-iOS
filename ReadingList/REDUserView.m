//
//  REDUserView.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDUserView.h"

@interface REDUserView ()

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
}

#pragma mark - layout
-(void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - setters
-(void)setUser:(id<REDUserProtocol>)user {
    _user = user;
    
}

#pragma mark - actions
-(IBAction)addAction:(id)sender {
    [self.delegate userViewWantsToAddCustomLog:self];
}
-(IBAction)pickPhoto:(id)sender {
    [self.delegate userViewWantsToSelectProfilePhoto:self];
}

#pragma mark - dealloc
-(void)dealloc {
    
}

@end
