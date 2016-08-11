//
//  TKLoader.h
//  searchLib
//
//  Created by Ignacio Giagante on 11/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const itemsLoaded = @"itemsLoaded";
static NSString * const itemCreated = @"itemCreated";
typedef void (^CompleteHandler)(void);

@interface TKLoader : NSObject

+(instancetype) loader;
-(void) search:(NSString *) input;

@end
