//
//  Item.m
//  searchWithLib
//
//  Created by Ignacio Giagante on 9/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "Item.h"

@implementation Item

- (id)init
{
    self = [super init];
    if (self)
    {
        // superclass successfully initialized, further
        // initialization happens here ...
    }
    return self;
}

- (id) initWithName:(NSString *)title price:(NSNumber *)price thumbnail:(NSString*)thumbnail {
    
    _title = title;
    _price = price;
    _thumbnail = thumbnail;
    return self;
}

@end
