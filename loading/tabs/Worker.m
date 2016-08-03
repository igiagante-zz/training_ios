//
//  Worker.m
//  tabs
//
//  Created by Ignacio Giagante on 3/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "Worker.h"
#import "PersistenceManager.h"
#import "Item.h"

static int const numberOfItems = 1000;
static int const module = 100;

@interface Worker ()

@end

@implementation Worker

+(instancetype) worker
{
    static Worker * worker = nil;
    static dispatch_once_t one = 0;
    dispatch_once(&one, ^{
        worker = [[Worker alloc]init];
    });
    return worker;
}

-(void) doNotification: (id) result {
    [[NSNotificationCenter defaultCenter] postNotificationName:itemsCreated object:result];
}

- (void) createItems:(CompleteHandler)handler withProgressBar:(UIProgressView *) progressBar
{
    dispatch_queue_t queue = dispatch_queue_create("com.company.app.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        
        for (int i = 0; i <= numberOfItems; i++)
        {
            Item *item = [Item alloc];
            [item setName: [NSString stringWithFormat:@"%@/%i", @"name", i]];
            [item setDesc: [NSString stringWithFormat:@"%@/%i", @"desc", i]];
            [item setImage:[UIImage imageNamed: @"no_image.png"]];
            
            [[PersistenceManager sharedInstance] addNewItem:item];
            
            if(i % module == 0){
                float progressValue = (float)i / numberOfItems;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   [self performSelectorOnMainThread: @selector(doNotification:) withObject: @(progressValue) waitUntilDone: NO];
                });
            }
        }
        
        if (!handler) {
            return;
        }
    });
}

@end
