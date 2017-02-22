//
//  REDBookNameValidatorTest.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/29/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "REDValidator.h"
#import "REDBookNameValidator.h"

@interface REDBookNameValidatorTest : XCTestCase

@property (strong, nonatomic) id<REDValidator> bookNameValidator;

@end

@implementation REDBookNameValidatorTest

#pragma mark - setup
-(void)setUp {
    [super setUp];
    self.bookNameValidator = [[REDBookNameValidator alloc] init];
}

#pragma mark - tests
-(void)testBookNameLength {
    NSString * noLengthBookName = @"";
    NSError *error;
    XCTAssertFalse([self.bookNameValidator validate:noLengthBookName error:&error]);
    XCTAssertNotNil(error);
}
-(void)testBookNameWithBookName {
    NSString * bookName = @"Book Name";
    NSError *error;
    XCTAssertFalse([self.bookNameValidator validate:bookName error:&error]);
    XCTAssertNotNil(error);
}
-(void)testOkBookName {
    NSString * bookName = @"RandomBookName";
    NSError *error;
    XCTAssertTrue([self.bookNameValidator validate:bookName error:&error]);
    XCTAssertNil(error);
}


@end
