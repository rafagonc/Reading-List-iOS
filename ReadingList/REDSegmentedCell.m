//
//  REDSegmentedCell.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDSegmentedCell.h"
#import "LUNSegmentedControl.h"
#import "REDLUNSegmentedControlDatasource.h"
#import "REDLibrarySegmentedControlDatasourceDelegate.h"
#import "UIColor+ReadingList.h"

@interface REDSegmentedCell () <REDLibrarySegmentedControlDatasourceDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet LUNSegmentedControl *segmentedControl;

#pragma mark - injected
@property (setter=injected:) id<REDLUNSegmentedControlDatasource> datasource;

@end

@implementation REDSegmentedCell

#pragma mark - constructor
-(instancetype)init {
    self = [[[NSBundle mainBundle] loadNibNamed:@"REDSegmentedCell" owner:self options:nil] firstObject];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.datasource setDelegate:self];
        [self.segmentedControl setClipsToBounds:NO];
        [self.segmentedControl setSelectorViewColor:[UIColor red_redColor]];
        [self.segmentedControl setDelegate:self.datasource];
        [self.segmentedControl setDataSource:self.datasource];
        [self.segmentedControl setShadowsEnabled:NO];
        [self.segmentedControl setShapeStyle:LUNSegmentedControlShapeStyleLiquid];
    } return self;
}

#pragma mark - delegate
-(void)librarySegmentedControlDatasource:(id<REDLUNSegmentedControlDatasource>)datasource justChoseIndex:(NSInteger)index {
    [self.delegate segmetedCell:self wantsToChangeType:index];
}
-(void)librarySegmentedControlDatasource:(id<REDLUNSegmentedControlDatasource>)datasource willChooseIndex:(NSInteger)index {
    [self.delegate segmetedCell:self willChangeType:index];
}
-(void)changeSelectedSegmentedControl:(NSUInteger)index {
    [self.segmentedControl setCurrentState:index];
}

@end
