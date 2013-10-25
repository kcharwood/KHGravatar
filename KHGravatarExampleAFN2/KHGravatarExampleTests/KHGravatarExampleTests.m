//
//  KHGravatarExampleTests.m
//  KHGravatarExampleTests
//
//  Created by Kevin Harwood on 10/24/13.
//  Copyright (c) 2013 Kevin Harwood. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KHGravatar.h"

@interface KHGravatarExampleTests : XCTestCase

@end

@implementation KHGravatarExampleTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBasicEmailURLHashWorks
{
    NSURL * url = [KHGravatar URLForGravatarEmailAddress:@"kcharwood@gmail.com"];
    XCTAssertTrue([[url absoluteString] rangeOfString:@"a892465144b53062338d0086d2139bcb"].location != NSNotFound, @"Correct Hash Not Found");
}

- (void)testBasicEmailURLDoesNotIncludeQueryParameters
{
    NSURL * url = [KHGravatar URLForGravatarEmailAddress:@"kcharwood@gmail.com"];
    XCTAssertNil(url.query, @"Query not nil for basic email request");
}

@end
