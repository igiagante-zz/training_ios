//
//  ViewController.m
//  item
//
//  Created by Ignacio Giagante on 22/7/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UITextField *itemName;
@property (weak, nonatomic) IBOutlet UITextField *itemDescription;
@property (weak, nonatomic) IBOutlet UIPickerView *itemCategory;

@property (weak, nonatomic) NSString * category;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)chooseImage:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _categories = @[@"Tools", @"Shoes",@"phone", @"computer", @"TV"];
    
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *name = [defaults objectForKey:@"itemName"];
    NSString *description = [defaults objectForKey:@"itemDescription"];
    NSString *category = [defaults objectForKey:@"itemCategory"];
    
    NSData *imageData = [defaults dataForKey:@"image"];
    UIImage *itemImage = [UIImage imageWithData:imageData];
    
    // Update the UI elements with the saved data
    _itemName.text = name;
    _itemDescription.text = description;
    _itemImageView.image = itemImage;
    
    _itemCategory.delegate = self;
    self.itemCategory.dataSource = self;
    
    
    NSUInteger iii =  [self.categories indexOfObject:category];
    
//    if(category){
//        [self.itemCategory selectedRowInComponent:[self.categories indexOfObject:category] ];
//    } else {
//        [self.itemCategory selectedRowInComponent:[self.categories indexOfObject:@"Tools"] ];
//    }
    
    [self.itemCategory selectedRowInComponent: iii];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _categories.count;
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.categories[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.category = self.categories[row];
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)save:(id)sender {
    
    // Hide the keyboard
    [self.itemName resignFirstResponder];
    [self.itemDescription resignFirstResponder];
    
    NSString *itemName = [self.itemName text];
    NSString *itemDescription  = [self.itemDescription text];
    
    // Create instances of NSData
    UIImage *itemImage = self.itemImageView.image;
    NSData *imageData = UIImageJPEGRepresentation(itemImage, 100);
    
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:itemName forKey:@"itemName"];
    [defaults setObject:itemDescription forKey:@"itemDescription"];
    [defaults setObject:self.category forKey:@"itemCategory"];
    [defaults setObject:imageData forKey:@"image"];
    
    [defaults synchronize];
    
    NSLog(@"Data saved");
}

- (IBAction)cancel:(id)sender {
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
