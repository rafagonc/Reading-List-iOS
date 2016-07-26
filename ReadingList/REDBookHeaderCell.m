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
#import "UIImageView+WebCache.h"
#import "REDTransactionManager.h"
#import "UIColor+ReadingList.h"
#import "HCSStarRatingView.h"

@interface REDBookHeaderCell ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIButton *coverButton;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIButton *heartButton;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starRatingView;
@property (weak, nonatomic) IBOutlet UIButton *addNoteButton;
@property (weak, nonatomic) IBOutlet UIButton *shareProgressButton;

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
        
        [self.coverButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        [self.addNoteButton.imageView setTintColor:[UIColor whiteColor]];
        [self.addNoteButton setImage:[[UIImage imageNamed:@"add_note-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        
        [self.shareProgressButton.imageView setTintColor:[UIColor whiteColor]];
        [self.shareProgressButton setImage:[[UIImage imageNamed:@"gauge"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        
        [self.descriptionTextView setText:@"Click to open description"];
        [self.descriptionTextView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedSnippet:)]];
        
        //rating setup
        UIImage *starImage = [UIImage imageNamed:@"stare"];
        starImage = [starImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage *highlightedStarImage = [UIImage imageNamed:@"starf"];
        highlightedStarImage = [highlightedStarImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.starRatingView.emptyStarImage = starImage;
        self.starRatingView.filledStarImage = highlightedStarImage;
        self.starRatingView.tintColor = [UIColor red_redColor];
        [self.starRatingView addTarget:self action:@selector(starRated:) forControlEvents:UIControlEventValueChanged];
        
    } return self;
}

#pragma mark - setters
-(void)setBook:(id<REDBookProtocol>)book {
    _book = book;
    [self setCoverImage:[book coverImage]];
    [self setAuthor:[book author]];
    [self.starRatingView setValue:[book rate]];
    [self.heartButton setTintColor:[UIColor red_redColor]];
    [self.heartButton setImage:[book loved] ? [[UIImage imageNamed:@"heart_fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] : [[[UIImage imageNamed:@"heart"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    if ([book name].length) [self.nameTextField setText:[book name]];
}
-(void)setAuthor:(id<REDAuthorProtocol>)author {
    _author = author;
    [self.authorButton setTitle:author ? [author name] : @"Tap to choose author" forState:UIControlStateNormal];
    [self.authorButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
}
-(void)setCoverImage:(UIImage *)coverImage {
    _coverImage = coverImage;
    if (coverImage) {
        [self.coverImageView setImage:coverImage ? [coverImage applyBlurToImageWithRadius:40.0f] : [UIImage imageNamed:@"default_blur"]];
        [self.coverButton setTitle:coverImage ? @"" : @"cover" forState:UIControlStateNormal];
        [self.coverButton setBackgroundImage:coverImage forState:UIControlStateNormal];
    } else if ([self.book coverURL]) {
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[self.book coverURL]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self.coverImageView setImage:image];
        }];
    }
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

#pragma mark - getters
-(CGFloat)rating {
    return self.starRatingView.value;
}

#pragma mark - chain of responsiblity
-(BOOL)setNewValuesOnBook:(id<REDBookProtocol>)book error:(NSError *__autoreleasing *)error {
    if (![self.bookNameValidator validate:self.nameTextField.text error:error]) return NO;
    if (![self.authorValidator validate:self.author error:error]) return NO;
    [book setLoved:self.heart];
    [book setRate:self.starRatingView.value];
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
        return MAX([self.snippet boundingRectWithSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont AvenirNextRegularWithSize:15.0f]} context:nil].size.height + self.descriptionTextView.frame.origin.y + 10, 312);
    } else {
        return 312;
    }
}

#pragma mark - actions
-(void)tappedSnippet:(UITapGestureRecognizer *)tap {
    self.snippetOpen = !self.snippetOpen;
    [self.delegate didSelectSnippetTextViewInBookHeaderCell:self];
}
-(IBAction)authorAction:(id)sender {
    [self.delegate didSelectAuthorInBookHeaderCell:self];
}
-(IBAction)coverAction:(id)sender {
    [self.delegate didSelectCoverInBookHeaderCell:self];
}
-(IBAction)heartAction:(id)sender {
    self.heart = !self.heart;
}
-(IBAction)starRated:(id)sender {
    if (self.starRatingView.value > 0) self.didChangeRate = YES;
}
-(IBAction)addNote:(id)sender {
    [self.delegate bookHeaderCellWantsToAddNote:self];
}
-(IBAction)shareProgressAction:(id)sender {
    [self.delegate bookHeaderCellWantsToShareProgress:self];
}

@end
