//
//  NavigationTestUITests.m
//  NavigationTestUITests
//
//  Created by 王欣 on 2018/2/7.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NavigationTestUITests : XCTestCase

@end

@implementation NavigationTestUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    [self testss];
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

-(void)testss{
    
    XCUIElementQuery *tablesQuery = [[XCUIApplication alloc] init].tables;
    [[[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:4].staticTexts[@"test"] swipeUp];
    [[[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:13].staticTexts[@"test"] tap];
    [[[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:14].staticTexts[@"test"] tap];
    [[[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:15].staticTexts[@"test"] tap];
    
    XCUIElement *testStaticText = [[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:16].staticTexts[@"test"];
    [testStaticText tap];
    [testStaticText swipeUp];
    [[[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:19].staticTexts[@"test"] tap];
    
}
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
