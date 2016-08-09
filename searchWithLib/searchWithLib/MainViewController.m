//
//  MainViewController.m
//  search
//
//  Created by Ignacio Giagante on 4/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "MainViewController.h"
#import "ListViewController.h"

@interface MainViewController ()

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

- (IBAction)search:(id)sender {

    NSString *text = self.inputSearch.text;
    ListViewController *list = [[ListViewController alloc]initWithData:text];
    [self.navigationController pushViewController:list animated:YES];
}
@end

