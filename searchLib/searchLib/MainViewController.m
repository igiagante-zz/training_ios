//
//  MainViewController.m
//  searchLib
//
//  Created by Ignacio Giagante on 11/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "MainViewController.h"
#import "ListViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputSearch;

- (IBAction)search:(id)sender;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)search:(id)sender {
    NSString *text = self.inputSearch.text;
    ListViewController *list = [[ListViewController alloc]initWithData:text];
    [self.navigationController pushViewController:list animated:YES];
}
@end
