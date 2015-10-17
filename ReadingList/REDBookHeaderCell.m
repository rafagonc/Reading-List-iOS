//
//  REDBookHeaderCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookHeaderCell.h"
#import "UITextField+DoneButton.h"

@interface REDBookHeaderCell ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIButton *coverButton;

@end

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
    [self setCoverImage:[book coverImage]];
    [self setAuthor:[book author]];
    [self.nameTextField setText:[book name]];
}
-(void)setAuthor:(id<REDAuthorProtocol>)author {
    _author = author;
    [self.authorButton setTitle:author ? [author name] : @"Author" forState:UIControlStateNormal];
    [self.authorButton setTitleColor:author ? [UIColor darkTextColor] : [UIColor lightGrayColor] forState:UIControlStateNormal];
}
-(void)setCoverImage:(UIImage *)coverImage {
    _coverImage = coverImage;
    [self.coverButton setTitle:coverImage ? @"" : @"cover" forState:UIControlStateNormal];
    [self.coverButton setBackgroundImage:coverImage forState:UIControlStateNormal];
}

#pragma mark - chain of responsiblity
-(BOOL)setNewValuesOnBook:(id<REDBookProtocol>)book error:(NSError *__autoreleasing *)error {
    if (self.nameTextField.text.length == 0) {
        *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey: @"Choose a book name."}];
        return NO;
    }
    if (self.authorButton.currentTitle == nil) {
        *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey: @"Choose an author."}];
        return NO;
    }
    [book setName:self.nameTextField.text];
    [book setAuthor:self.author];
    [book setCoverImage:self.coverButton.currentBackgroundImage];
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
