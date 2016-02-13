//
//  REDLogCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "UIFont+ReadingList.h"
#import "REDLogCell.h"
#import "REDBookDataAccessObject.h"
#import "REDBookAddViewController.h"

@interface REDLogCell () <UITextViewDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

#pragma mark - injected
@property (setter=injected:,readonly) id<REDBookDataAccessObject> bookDataAccessObject;

@end

@implementation REDLogCell

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } return self;
}

#pragma mark - getters and setters
-(void)setRead:(id<REDReadProtocol>)read {
    _read = read;
    self.coverImageView.image = [[read book] coverImage];
    
    //attr string
    if (![read book]) {
        return;
    }
    NSString * descString = [NSString stringWithFormat:@"Read %lu pages of the book %@", (long)[read pagesValue], [[read book] name]];
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:descString];
    [attrString addAttribute:NSFontAttributeName value:[UIFont AvenirNextRegularWithSize:15.f] range:NSMakeRange(0,[descString rangeOfString:[[read book]name]].location)];
    [attrString addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"book"] range:[descString rangeOfString:[[read book] name]]];
    [attrString addAttribute:NSFontAttributeName value:[UIFont AvenirNextBoldWithSize:15.0f] range:[descString rangeOfString:[[read book] name]]];
    [self.textView setAttributedText:[attrString copy]];
    
    self.textView.linkTextAttributes = @{NSFontAttributeName : [UIFont AvenirNextBoldWithSize:15.0f],
                                         NSForegroundColorAttributeName : [UIColor darkTextColor]};
    self.textView.delegate = self;
    
}

#pragma mark - text view delegate
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSString *bookName = [[self.read book] name];
    id<REDBookProtocol> book = [[self.bookDataAccessObject searchBooksWithString:bookName] firstObject];
    [self.delegate logCell:self wantsToCheckOutBook:book];
    return YES;
}

@end
