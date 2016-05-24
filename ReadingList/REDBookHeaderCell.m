//
//  REDBookHeaderCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookHeaderCell.h"
#import "UITextField+DoneButton.h"
#import "UIImage+Blur.h"
#import "REDValidator.h"
#import "UIFont+ReadingList.h"
#import "REDTransactionManager.h"

@interface REDBookHeaderCell ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIButton *coverButton;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIButton *heartButton;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *shadowView;

#pragma mark - properties
@property (nonatomic,assign) BOOL heart;

#pragma mark - injected
@property (setter=injected_name:) id<REDValidator> bookNameValidator;
@property (setter=injected_author:) id<REDValidator> authorValidator;
@property (setter=injected:) id<REDTransactionManager> transactionManager;

#pragma mark - properties
@property (nonatomic,assign) BOOL snippetOpen;


@end

@implementation REDBookHeaderCell

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.nameTextField addToolbar];
        
        self.shadowView.layer.masksToBounds = NO;
        self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.shadowView.layer.shadowRadius = 20.f;
        self.shadowView.layer.shadowOpacity = 0.6;
        self.shadowView.layer.shadowOffset = CGSizeMake(0, 30);
        
        [self.descriptionTextView setText:@"Click to open description"];
        [self.descriptionTextView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedSnippet:)]];
    } return self;
}

#pragma mark - setters
-(void)setBook:(id<REDBookProtocol>)book {
    _book = book;
    [self setCoverImage:[book coverImage]];
    [self setAuthor:[book author]];
    [self.heartButton setImage:[book loved] ? [[UIImage imageNamed:@"heart_fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] : [[UIImage imageNamed:@"heart"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    if ([book name].length) [self.nameTextField setText:[book name]];
}
-(void)setAuthor:(id<REDAuthorProtocol>)author {
    _author = author;
    [self.authorButton setTitle:author ? [author name] : @"Author" forState:UIControlStateNormal];
    [self.authorButton setTitleColor:author ? [UIColor whiteColor] : [UIColor whiteColor] forState:UIControlStateNormal];
}
-(void)setCoverImage:(UIImage *)coverImage {
    _coverImage = coverImage;
    [self.coverImageView setImage:coverImage ? [coverImage applyBlurToImageWithRadius:40.0f] : [UIImage imageNamed:@"default_blur"]];
    [self.coverButton setTitle:coverImage ? @"" : @"cover" forState:UIControlStateNormal];
    [self.coverButton setBackgroundImage:coverImage forState:UIControlStateNormal];
}
-(void)setSnippet:(NSString *)snippet {
    _snippet = snippet;
}
-(void)setIsLoading:(BOOL)isLoading {
    _isLoading = isLoading;
    if (isLoading) {
        [self.activityIndicator startAnimating];
    } else {
        [self.activityIndicator stopAnimating];
    }
}
-(void)setSnippetOpen:(BOOL)snippetOpen {
    _snippetOpen = snippetOpen;
    if (!snippetOpen) {
        if (self.snippet.length > 0) {
            [self.descriptionTextView setText:@"Click to open description"];
        } else {
            [self.descriptionTextView setText:@"No description Avaliable"];
        }
    } else {
        [self.descriptionTextView setText:self.snippet];
    }
}
-(void)setHeart:(BOOL)heart {
    _heart = heart;
    [self.heartButton setImage:heart ? [[UIImage imageNamed:@"heart_fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] : [[UIImage imageNamed:@"heart"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}

#pragma mark - actions
-(void)tappedSnippet:(UITapGestureRecognizer *)tap {
    self.snippetOpen = !self.snippetOpen;
    [self.delegate didSelectSnippetTextViewInBookHeaderCell:self];
}

#pragma mark - chain of responsiblity
-(BOOL)setNewValuesOnBook:(id<REDBookProtocol>)book error:(NSError *__autoreleasing *)error {
    if (![self.bookNameValidator validate:self.nameTextField.text error:error]) return NO;
    if (![self.authorValidator validate:self.author error:error]) return NO;
    [book setLoved:self.heart];
    [book setName:self.nameTextField.text];
    [book setAuthor:self.author];
    [book setCoverImage:self.coverButton.currentBackgroundImage];
    [book setSnippet:self.snippet];
    [book setCoverURL:self.coverURL];
    return YES;
}

#pragma mark - height
-(CGFloat)height {
    if (self.snippetOpen) {
        return MAX([self.snippet boundingRectWithSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont AvenirNextRegularWithSize:15.0f]} context:nil].size.height + self.descriptionTextView.frame.origin.y, 235);
    } else {
        return 235;
    }
}

#pragma mark - actions
-(IBAction)authorAction:(id)sender {
    [self.delegate didSelectAuthorInBookHeaderCell:self];
}
-(IBAction)coverAction:(id)sender {
    [self.delegate didSelectCoverInBookHeaderCell:self];
}
-(IBAction)heartAction:(id)sender {
    self.heart = !self.heart;
}

@end
