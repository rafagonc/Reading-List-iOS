//
//  REDLibrarySegmentedControlDatasource.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLibrarySegmentedControlDatasource.h"
#import "UIFont+ReadingList.h"
#import "REDLibrarySegmentedControlDatasourceDelegate.h"

@interface REDLibrarySegmentedControlDatasource ()

@property (nonatomic,strong) NSArray * options;

@end

@implementation REDLibrarySegmentedControlDatasource

@synthesize delegate;

#pragma mark - constructor
-(instancetype)init {
    if (self = [super init]) {
        self.options = @[@"Books", @"Authors", @"Categories", @"Logs"];
    } return self;
}

#pragma mark - delegate
-(NSInteger)numberOfStatesInSegmentedControl:(LUNSegmentedControl *)segmentedControl {
    return self.options.count;
}
-(NSAttributedString *)segmentedControl:(LUNSegmentedControl *)segmentedControl attributedTitleForStateAtIndex:(NSInteger)index {
    NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:self.options[index] attributes:@{NSFontAttributeName : [UIFont AvenirNextRegularWithSize:14.f]}];
    return attrString;
}

- (void)segmentedControl:(LUNSegmentedControl *)segmentedControl didChangeStateFromStateAtIndex:(NSInteger)fromIndex toStateAtIndex:(NSInteger)toIndex;{
    [self.delegate librarySegmentedControlDatasource:self justChoseIndex:toIndex];
}

@end
