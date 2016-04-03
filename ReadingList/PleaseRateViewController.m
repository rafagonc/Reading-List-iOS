//
//  PleaseRateViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "PleaseRateViewController.h"
#import "REDBookUploaderProtocol.h"
#import "REDBookProtocol.h"
#import "HCSStarRatingView.h"

@interface PleaseRateViewController ()

#pragma mark - propeties
@property (nonatomic,strong) id<REDBookProtocol> book;

#pragma mark - ui
@property (weak, nonatomic) IBOutlet HCSStarRatingView *ratingView;

#pragma mark - injected
@property (setter=injected:) id<REDBookUploaderProtocol> bookUploader;

@end

@implementation PleaseRateViewController

#pragma mark - constructor
-(instancetype)initWithBook:(id<REDBookProtocol>)book {
    if (self = [super init]) {
        self.animationType = PopoverViewControllerAnimationTypeCrossDissolve;
        self.size = CGSizeMake([UIScreen mainScreen].bounds.size.width * .9f, 320);
        self.book = book;
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.cornerRadius = 12;
    
    self.ratingView.emptyStarImage = [UIImage imageNamed:@"StarEmpty"];
    self.ratingView.filledStarImage = [UIImage imageNamed:@"Star"];
    
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

#pragma mark - dealloc
-(void)dealloc {
}

@end
