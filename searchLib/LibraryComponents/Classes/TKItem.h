//
//  TKItem.h
//  searchLib
//
//  Created by Ignacio Giagante on 11/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TKItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSNumber *price;
@property (nonatomic, strong) NSString *thumbnail;

- (id) initWithName:(NSString *)title price:(NSNumber *)price thumbnail:(NSData*)thumbnail;

@end
