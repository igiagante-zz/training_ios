//
//  ItemViewController.m
//  tabs
//
//  Created by Ignacio Giagante on 30/7/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "ItemViewController.h"
#import "JUKLTabBarViewController.h"
#import "Item.h"
#import "PersistenceManager.h"

#define kOFFSET_FOR_KEYBOARD 80.0

@interface ItemViewController ()
@property (weak, nonatomic) IBOutlet UITextField *itemName;
@property (weak, nonatomic) IBOutlet UITextField *itemDescription;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
- (IBAction)save:(id)sender;
- (IBAction)chooseImage:(id)sender;
@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _itemName.delegate = self;
    _itemDescription.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self setViewMovedUp:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self setViewMovedUp:NO];
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

- (IBAction)save:(id)sender {
    
    // Hide the keyboard
    [self.itemName resignFirstResponder];
    [self.itemDescription resignFirstResponder];

    UIImage *itemImage = self.itemImageView.image;
    
    Item * item = [[Item alloc] init];
    item.name = [self.itemName text];
    item.desc = [self.itemDescription text];
    item.image = itemImage;
    
    [[PersistenceManager sharedInstance] addNewItem:item];
    
    [self cleanFields];
    
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
    
    NSLog(@"Data saved");
}

- (void) cleanFields {
    self.itemName.text = @"";
    self.itemDescription.text = @"";
    //self.itemImageView.image = [UIImage alloc];
}

- (IBAction)chooseImage:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    self.itemImageView.image = image;
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
