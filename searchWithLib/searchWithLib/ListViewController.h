//
//  ListViewController.h
//  searchWithLib
//
//  Created by Ignacio Giagante on 9/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"

@interface ListViewController : ViewController <MBProgressHUDDelegate>

- (instancetype) initWithData:(NSString *) inputSearch;

@end
