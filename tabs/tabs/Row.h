//
//  Row.h
//  tabs
//
//  Created by Ignacio Giagante on 1/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Row : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UILabel *desc;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnail;

@end
