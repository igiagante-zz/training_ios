//
//  Item.h
//  tabs
//
//  Created by Ignacio Giagante on 1/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Item : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) UIImage *image;

- (id) initWithName:(NSString *)name description:(NSString *)desc image:(NSData*)image;

@end
