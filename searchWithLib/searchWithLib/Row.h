//
//  Row.h
//  searchWithLib
//
//  Created by Ignacio Giagante on 9/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Row : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (nonatomic, assign) NSInteger myTag;
@end
