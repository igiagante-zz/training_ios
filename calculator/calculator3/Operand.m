//
//  Operand.m
//  calculator3
//
//  Created by Ignacio Giagante on 18/7/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "Operand.h"

@implementation Operand

- (id)initWithValue:(NSNumber *)number {
    self = [super init];
    if (self) {
        _value = [number copy];
        NSLog(@"value in init %.2f", number.doubleValue);
    }
    return self;
}

+ (NSArray *) operations {
    return @[@"+", @"-", @"/", @"*"];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"value is %.2f", [_value doubleValue]];
}

- (Operand *) add:(Operand *)that
{
    Operand *operand = [[Operand alloc] init];
    NSNumber *result = [NSNumber numberWithDouble: self.value.doubleValue + that.value.doubleValue];
    operand.value = result;
    
    return operand;
}

- (Operand *) subtract:(Operand *)that
{
    Operand *operand = [[Operand alloc] init];
    NSNumber *result = [NSNumber numberWithDouble: self.value.doubleValue - that.value.doubleValue];
    operand.value = result;
    
    return operand;
}

- (Operand *) multiple:(Operand *)that
{
    Operand *operand = [[Operand alloc] init];
    NSNumber *result = [NSNumber numberWithDouble: self.value.doubleValue * that.value.doubleValue];
    operand.value = result;
    
    return operand;
}

- (Operand *) divide:(Operand *)that
{
    Operand *operand = [[Operand alloc] init];
    NSNumber *result = [NSNumber numberWithDouble: self.value.doubleValue / that.value.doubleValue];
    operand.value = result;
    
    return operand;
}

@end

