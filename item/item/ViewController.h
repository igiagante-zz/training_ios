//
//  ViewController.h
//  item
//
//  Created by Ignacio Giagante on 22/7/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (strong, nonatomic) NSArray *categories;
@end

