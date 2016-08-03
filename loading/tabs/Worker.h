//
//  Worker.h
//  tabs
//
//  Created by Ignacio Giagante on 3/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString * const itemsCreated = @"itemsCreated";

typedef void (^CompleteHandler)(void);

@interface Worker : NSObject

+(instancetype) worker;

- (void) createItems:(CompleteHandler)handler withProgressBar:(UIProgressView *) progressBar;
@end
