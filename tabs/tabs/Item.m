//
//  Item.m
//  tabs
//
//  Created by Ignacio Giagante on 1/8/16.
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

- (id) initWithName:(NSString *)name description:(NSString *)desc image:(UIImage*)image {
    
    _name = name;
    _desc = desc;
    _image = image;
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_desc forKey:@"desc"];
    [coder encodeObject:_image forKey:@"image"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super init];
    if (self != nil)
    {
        _name = [coder decodeObjectForKey:@"name"];
        _desc = [coder decodeObjectForKey:@"desc"];
        _image = [coder decodeObjectForKey:@"image"];
    }
    return self;
}

@end
