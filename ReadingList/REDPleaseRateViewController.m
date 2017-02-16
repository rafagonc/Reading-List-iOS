//
//  PleaseRateViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDPleaseRateViewController.h"
#import "REDBookUploaderProtocol.h"
#import "REDBookProtocol.h"
#import "HCSStarRatingView.h"
#import "REDShareFactory.h"

@interface REDPleaseRateViewController ()

#pragma mark - propeties
@property (nonatomic,strong) id<REDBookProtocol> book;

#pragma mark - ui
@property (weak, nonatomic) IBOutlet HCSStarRatingView *ratingView;
@property (weak, nonatomic) IBOutlet UIImageView *facebookImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twitterImageView;

#pragma mark - injected
@property (setter=injected2:) id<REDBookUploaderProtocol> bookUploader;
@property (setter=injected1:) id<REDShareFactory> shareFactory;

@end

@implementation REDPleaseRateViewController

#pragma mark - constructor
-(instancetype)initWithBook:(id<REDBookProtocol>)book {
    if (self = [super init]) {
        self.size = CGSizeMake([UIScreen mainScreen].bounds.size.width * .9f, 300);
        self.book = book;
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.cornerRadius = 12;
    
    [self.facebookImageView setImage:[[UIImage imageNamed:@"facebook-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [self.facebookImageView setTintColor:[UIColor whiteColor]];
    [self.twitterImageView setImage:[[UIImage imageNamed:@"twitter-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [self.twitterImageView setTintColor:[UIColor whiteColor]];
    
    self.ratingView.emptyStarImage = [[UIImage imageNamed:@"stare"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.ratingView.filledStarImage = [[UIImage imageNamed:@"starf"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [self.ratingView addTarget:self action:@selector(finishedRating:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - actions
-(void)finishedRating:(HCSStarRatingView *)ratingView {
    
}
-(IBAction)closeAction:(id)sender {
    if (self.ratingView.value > 0) {
        [self.bookUploader uploadBook:self.book forRating:self.ratingView.value];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)twitterAction:(id)sender {
    [[self.shareFactory shareForType:REDShareTypeTwitter] share:[self.book coverImage] with:[NSString stringWithFormat:@"Just finished %@", [self.book name]] from:self];
}
-(IBAction)facebookAction:(id)sender {
    [[self.shareFactory shareForType:REDShareTypeFacebook] share:[self.book coverImage] with:[NSString stringWithFormat:@"Just finished %@", [self.book name]] from:self];
}

#pragma mark - dealloc
-(void)dealloc {
}

@end
