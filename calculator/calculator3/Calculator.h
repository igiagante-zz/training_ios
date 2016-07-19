//
//  Calculator.h
//  calculator3
//
//  Created by Ignacio Giagante on 19/7/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#ifndef Calculator_h
#define Calculator_h


#endif /* Calculator_h */

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

@property (nonatomic, getter=isTypingNumber) BOOL typingNumber;
@property (nonatomic) double valueOne;
@property (nonatomic) double valueTwo;
@property (nonatomic, copy) NSString *operation;

- (int) convertDoubleToInt: (double)value;
- (NSString *) performOperation;

@end
