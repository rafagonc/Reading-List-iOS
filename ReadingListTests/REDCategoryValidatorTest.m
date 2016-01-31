//
//  REDCategoryValidator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/29/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "REDCategoryProtocol.h"
#import "REDCategoryValidator.h"
#import "REDValidator.h"
#import "REDCategory.h"
#import <OCMock/OCMock.h>

@interface REDCategoryValidatorTest : XCTestCase

@property (nonatomic,strong) id<REDValidator> categoryValidator;
@property (nonatomic,strong) id<REDCategoryProtocol> category;

@end

@implementation REDCategoryValidatorTest

#pragma mark - setup
-(void)setUp {
    [super setUp];
    self.categoryValidator = [[REDCategoryValidator alloc] init];
}

#pragma mark - test
-(void)testCategoryWithCorrectInfo {
    id<REDCategoryProtocol> category = OCMClassMock([REDCategory class]);
    OCMStub([category name]).andReturn(@"Category");
}

@end
