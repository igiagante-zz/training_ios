//
//  Operand.h
//  calculator3
//
//  Created by Ignacio Giagante on 18/7/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#ifndef Operand_h
#define Operand_h


#endif /* Operand_h */

#import <Foundation/Foundation.h>

@interface Operand : NSObject

@property (nonatomic) NSNumber* value;

+ (NSArray *) operations;
- (id)initWithValue:(Operand *)Operand;
- (Operand *) add:(Operand *)that;
- (Operand *) subtract:(Operand *)that;
- (Operand *) multiple:(Operand *)that;
- (Operand *) divide:(Operand *)that;

@end