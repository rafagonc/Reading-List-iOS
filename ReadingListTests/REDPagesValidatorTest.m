//
//  REDPagesValidator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/29/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "REDPagesValidator.h"

@interface REDPagesValidatorTest : XCTestCase

@property (nonatomic,strong) id<REDValidator> pagesValidator;

@end

@implementation REDPagesValidatorTest

#pragma mark - setup
-(void)setUp {
    [super setUp];
    self.pagesValidator = [[REDPagesValidator alloc] init];
}

#pragma mark - test
-(void)testValid {
    NSError *error;
    NSString * testString = @"123";
    XCTAssertTrue([self.pagesValidator validate:testString error:&error]);
    XCTAssertNil(error);
}
-(void)testWithLetters {
    NSError *error;
    NSString * testString = @"12da3";
    XCTAssertFalse([self.pagesValidator validate:testString error:&error]);
    XCTAssertNotNil(error);
}


@end
