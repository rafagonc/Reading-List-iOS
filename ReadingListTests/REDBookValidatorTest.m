//
//  REDBookValidator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/29/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "REDBookValidator.h"
#import "REDBookProtocol.h"
#import "REDRLMBook.h"
#import <OCMock/OCMock.h>

@interface REDBookValidatorTest : XCTestCase

@property (nonatomic,strong) id<REDValidator> bookValidator;

@end

@implementation REDBookValidatorTest

#pragma mark - setup
-(void)setUp {
    [super setUp];
    self.bookValidator = [[REDBookValidator alloc] init];
}

#pragma mark - test
-(void)testValid {
    id<REDBookProtocol> book = OCMClassMock([REDRLMBook class]);
    XCTAssertTrue([self.bookValidator validate:book error:nil]);
}
-(void)testNil {
    XCTAssertFalse([self.bookValidator validate:nil error:nil]);
}

@end
