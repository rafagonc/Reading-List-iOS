//
//  REDDateValidator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/29/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "REDDateValidator.h"
#import "NSDate+Escort.h"

@interface REDDateValidatorTest : XCTestCase

@property (nonatomic,strong) id<REDValidator> dateValidator;

@end

@implementation REDDateValidatorTest

#pragma mark - setup
-(void)setUp {
    [super setUp];
    self.dateValidator = [[REDDateValidator alloc] init];
}

#pragma mark - test
-(void)testValid {
    NSDate *dateBefore = [[NSDate date] dateBySubtractingDays:1];
    XCTAssertTrue([self.dateValidator validate:dateBefore error:nil]);
}
-(void)testInvalid {
    NSDate *dateAfter = [[NSDate date] dateByAddingDays:1];
    XCTAssertFalse([self.dateValidator validate:dateAfter error:nil]);
}
-(void)testToday {
    NSDate *now = [NSDate date];
    XCTAssertTrue([self.dateValidator validate:now error:nil]);
}


@end
