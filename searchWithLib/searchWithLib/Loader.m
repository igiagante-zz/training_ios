//
//  Loader.m
//  search
//
//  Created by Ignacio Giagante on 4/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "Loader.h"
#import "UIKit/UIKit.h"
#import "Item.h"
#import "AFNetworking.h"

static const NSString * PATH = @"https://api.mercadolibre.com/sites/MLU/search?q=";

@interface Loader()
@property (nonatomic, weak) NSArray *items;
@end

@implementation Loader

+(instancetype) loader
{
    static Loader * loader = nil;
    static dispatch_once_t one = 0;
    dispatch_once(&one, ^{
        loader = [[Loader alloc]init];
    });
    return loader;
}

-(void) doNotification: (id) result {
    [[NSNotificationCenter defaultCenter] postNotificationName:itemsLoaded object:result];
}

-(void) search:(NSString *) input {
    
    NSMutableArray *items = [[NSMutableArray alloc]init];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", PATH, input]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSArray * results = [responseObject valueForKeyPath:@"results"];
        for(int i = 0; i < results.count; i++) {
            NSDictionary *dic = results[i];
            NSString * title = [dic valueForKeyPath:@"title"];
            NSNumber * price = [dic valueForKeyPath:@"price"];
            NSString * thumbnail = [dic valueForKeyPath:@"thumbnail"];
            
            Item *item = [Item alloc];
            item.title = title;
            item.price = price;
            item.thumbnail = thumbnail;
            
            [items addObject:item];
        }
        
        [self performSelectorOnMainThread: @selector(doNotification:) withObject: items waitUntilDone: NO];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSLog(@"Error connection %@", error);
        });
    }];
    
}
@end
