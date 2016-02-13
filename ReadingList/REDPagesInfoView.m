//
//  REDTotalPagesView.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/27/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDPagesInfoView.h"
#import "REDBookDataAccessObject.h"
#import "REDReadDataAccessObject.h"

@interface REDPagesInfoView ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UILabel *totalPagesLabel;
@property (weak, nonatomic) IBOutlet UILabel *perDayLabel;

#pragma mark - injected
@property (setter=injected:,readonly) id<REDBookDataAccessObject> bookDataAccessObject;
@property (setter=injected:,readonly) id<REDReadDataAccessObject> readDataAccessObject;

@end

@implementation REDPagesInfoView

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    if (self) {
        
    } return self;
}

#pragma mark - overrides
-(void)awakeFromNib {
    [super awakeFromNib];
    [self updateData];
}

#pragma mark - methods
-(void)updateData {
    self.totalPagesLabel.text = [NSString stringWithFormat:@"total pages read: %lu", (unsigned long)[self.bookDataAccessObject totalPages]];
    self.perDayLabel.text = [NSString stringWithFormat:@"pages read per day: %.1f", [self.readDataAccessObject perDay]];
}

@end
