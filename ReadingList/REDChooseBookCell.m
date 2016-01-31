//
//  REDChooseBookCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/27/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDChooseBookCell.h"
#import "REDValidator.h"

@interface REDChooseBookCell ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

#pragma mark - injected
@property (setter=injected_book:,readonly) id<REDValidator> bookValidator;

@end

@implementation REDChooseBookCell

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        
    } return self;
}

#pragma mark - setters
-(void)setBook:(id<REDBookProtocol>)book {
    _book = book;
    self.coverImageView.image = [book coverImage];
    self.nameLabel.text = [book name];
}

#pragma mark - chain
-(BOOL)process:(id<REDReadProtocol>)read error:(NSError *__autoreleasing *)error {
    if (![self.bookValidator validate:self.book error:error]) return NO;
    [read setBook:self.book];
    return YES;
}

#pragma mark - methods
-(void)selected {
    [self.delegate chooseBookCellWantsToChooseBook:self];
}

@end
