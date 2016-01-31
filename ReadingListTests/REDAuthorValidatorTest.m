//
//  REDAuthorValidatorTest.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/29/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "REDAuthorProtocol.h"
#import <OCMock/OCMock.h>
#import "REDAuthor.h"
#import "REDValidator.h"
#import "REDAuthorValidator.h"

@interface REDAuthorValidatorTest : XCTestCase

@property (nonatomic,strong) id<REDAuthorProtocol> author;
@property (nonatomic,strong) id<REDValidator> authorValidator;

@end

@implementation REDAuthorValidatorTest

#pragma mark - setup
-(void)setUp {
    [super setUp];
    self.authorValidator = [[REDAuthorValidator alloc] init];
}

#pragma mark - test
-(void)testAuthorValidatorWithNoLengthName {
    self.author = OCMClassMock([REDAuthor class]);
    OCMStub([self.author name]).andReturn(@"");
    NSError *error;
    XCTAssertFalse([self.authorValidator validate:self.author error:&error]);
    XCTAssertNotNil(error);
}
-(void)testAuthorValidatorWithAuthorEqualsNil {
    NSError *error;
    XCTAssertFalse([self.authorValidator validate:self.author error:&error]);
    XCTAssertNotNil(error);
}
-(void)testAuthorValidatorWithCorrectInfo {
    self.author = OCMClassMock([REDAuthor class]);
    OCMStub([self.author name]).andReturn(@"Robert C Martin");
    NSError *error;
    XCTAssertTrue([self.authorValidator validate:self.author error:&error]);
    XCTAssertNil(error);
}

@end
