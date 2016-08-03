//
//  PersistenceManager.h
//  tabs
//
//  Created by Ignacio Giagante on 1/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Item.h"

@interface PersistenceManager : NSObject

+(instancetype) sharedInstance;

-(BOOL) addNewItem:(Item*)item;

-(NSArray*)loadItems;

@end
