//
//  PersistenceManager.m
//  tabs
//
//  Created by Ignacio Giagante on 1/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "PersistenceManager.h"

static NSString *const kListOfItemsKey = @"listOfItems";

@implementation PersistenceManager

+(instancetype) sharedInstance
{
    static PersistenceManager *_sharedInstace = nil;
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        _sharedInstace = [[PersistenceManager alloc] init];
    });
    return _sharedInstace;
}


-(BOOL) addNewItem:(Item*)item
{
    NSMutableArray *items = [NSMutableArray arrayWithArray:[self loadItems]];
    [items addObject:item];
    
    NSData *itemsData = [NSKeyedArchiver archivedDataWithRootObject:items];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:itemsData forKey:kListOfItemsKey];
    
    [defaults synchronize];
    
    return YES;
}

-(NSArray*)loadItems
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *itemsData = [defaults objectForKey:kListOfItemsKey];
    NSArray *listOfItems;
    if (itemsData) {
        listOfItems = [NSKeyedUnarchiver unarchiveObjectWithData:itemsData];
    } else {
        listOfItems = [[NSArray alloc] init];
    }
    
    return listOfItems;
}

@end
