//
//  calculator3Tests.m
//  calculator3Tests
//
//  Created by Ignacio Giagante on 18/7/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Calculator.h"

@interface calculator3Tests : XCTestCase

@end

@implementation calculator3Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPlusOperation {

    Calculator *calculator = [Calculator alloc];
    calculator.valueOne = 2;
    calculator.valueTwo = 3;
    calculator.operation = @"+";
    NSString * res = [calculator performOperation];
    
    XCTAssertTrue([res isEqualToString:@"5"]);
}

- (void)testDivideOperation {
    
    Calculator *calculator = [Calculator alloc];
    calculator.valueOne = 6;
    calculator.valueTwo = 2;
    calculator.operation = @"/";
    NSString * res = [calculator performOperation];
    
    XCTAssertTrue([res isEqualToString:@"3"]);
}

- (void)testSubtractOperation {
    
    Calculator *calculator = [Calculator alloc];
    calculator.valueOne = 3;
    calculator.valueTwo = 1;
    calculator.operation = @"-";
    NSString * res = [calculator performOperation];
    
    XCTAssertTrue([res isEqualToString:@"2"]);
}

- (void)testMultipleOperation {
    
    Calculator *calculator = [Calculator alloc];
    calculator.valueOne = 2;
    calculator.valueTwo = 3;
    calculator.operation = @"x";
    NSString * res = [calculator performOperation];
    
    XCTAssertTrue([res isEqualToString:@"6"]);
}

@end
