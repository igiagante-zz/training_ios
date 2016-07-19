//
//  Calculator.m
//  calculator3
//
//  Created by Ignacio Giagante on 19/7/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculator.h"

@implementation Calculator

- (int) convertDoubleToInt: (double)value {
    return (int)(value + (value > 0 ? 0.5 : -0.5));
}

- (NSString *) performOperation {
    
    double result = 0;
    
    if([self.operation isEqualToString:@"+"]) {
        result = self.valueTwo + self.valueOne;
    } else if([self.operation isEqualToString:@"-"]) {
        result = self.valueOne - self.valueTwo;
    } else if([self.operation isEqualToString:@"x"]) {
        result = self.valueTwo * self.valueOne;
    } else if([self.operation isEqualToString:@"/"]) {
        result = self.valueOne / self.valueTwo;
    } else if([self.operation isEqualToString:@"%"]) {
        result = [self convertDoubleToInt: self.valueTwo] % [self convertDoubleToInt :self.valueOne];
    }
    
    NSNumberFormatter *doubleValueWithMaxTwoDecimalPlaces = [[NSNumberFormatter alloc] init];
    [doubleValueWithMaxTwoDecimalPlaces setNumberStyle:NSNumberFormatterDecimalStyle];
    [doubleValueWithMaxTwoDecimalPlaces setMaximumFractionDigits:5];
    
    NSNumber *myValue = [NSNumber numberWithDouble:result];
    
    NSString* res = [doubleValueWithMaxTwoDecimalPlaces stringFromNumber:myValue];
    doubleValueWithMaxTwoDecimalPlaces = nil;
    
    return res;
}

@end