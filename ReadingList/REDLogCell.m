//
//  REDLogCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "UIFont+ReadingList.h"
#import "REDLogCell.h"

@interface REDLogCell () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@end

@implementation REDLogCell

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        
    } return self;
}

#pragma mark - getters and setters
-(void)setRead:(id<REDReadProtocol>)read {
    _read = read;
    self.coverImageView.image = [[read book] coverImage];
    
    //attr string
    NSString * descString = [NSString stringWithFormat:@"Read %lu pages of the book %@", [read pagesValue], [[read book] name]];
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
    
    NSLog(@"%@",URL);
    
    return YES;
}

@end
