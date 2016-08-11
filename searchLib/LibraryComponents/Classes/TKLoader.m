//
//  TKLoader.m
//  searchLib
//
//  Created by Ignacio Giagante on 11/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "TKLoader.h"
#import "UIKit/UIKit.h"
#import "TKItem.h"

static const NSString * PATH = @"https://api.mercadolibre.com/sites/MLU/search?q=";

@interface TKLoader()
@property (nonatomic, weak) NSArray *items;
@end

@implementation TKLoader

+(instancetype) loader
{
    static TKLoader * loader = nil;
    static dispatch_once_t one = 0;
    dispatch_once(&one, ^{
        loader = [[TKLoader alloc]init];
    });
    return loader;
}

-(void) notifyToProgressBar: (id) result {
    [[NSNotificationCenter defaultCenter] postNotificationName:itemCreated object:result];
}

-(void) doNotification: (id) result {
    [[NSNotificationCenter defaultCenter] postNotificationName:itemsLoaded object:result];
}

-(void) search:(NSString *) input {
    
    NSMutableArray *items = [[NSMutableArray alloc]init];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", PATH, input]];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    __weak TKLoader *weakSelf = self;
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // Check HTTP status code
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
        
        if (HTTPResponse.statusCode == 200) {
            // Convert from JSON to NSArray
            NSError *JSONError;
            NSArray *JSONnotes = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&JSONError];
            
            if (!JSONError) {
                
                NSArray * results = [JSONnotes valueForKeyPath:@"results"];
                for(int i = 0; i < results.count; i++) {
                    NSDictionary *dic = results[i];
                    NSString * title = [dic valueForKeyPath:@"title"];
                    NSNumber * price = [dic valueForKeyPath:@"price"];
                    NSString * thumbnail = [dic valueForKeyPath:@"thumbnail"];
                    
                    TKItem *item = [TKItem alloc];
                    item.title = title;
                    item.price = price;
                    item.thumbnail = thumbnail;
                    
                    [items addObject:item];
                    
                    float value = (float)(i + 1) / results.count;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        [weakSelf performSelectorOnMainThread: @selector(notifyToProgressBar:)
                                                   withObject: @(value) waitUntilDone: NO];
                    });
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [weakSelf performSelectorOnMainThread: @selector(doNotification:) withObject: items waitUntilDone: NO];
                });
                
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    NSLog(@"Parse JSON Error %@", JSONError);
                });
            }
        } else {
            NSError *error = [NSError errorWithDomain:@"SPOUserStoreNetworkingError" code:HTTPResponse.statusCode userInfo:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                NSLog(@"Error connection %@", error);
            });
        }
    }];
    
    [dataTask resume];
}

@end

