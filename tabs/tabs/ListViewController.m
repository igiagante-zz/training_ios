//
//  ListViewController.m
//  tabs
//
//  Created by Ignacio Giagante on 30/7/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "ListViewController.h"
#import "Item.h"
#import "ItemDetailViewController.h"
#import "PersistenceManager.h"
#import "Row.h"

@interface ListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ListViewController

NSArray *tableData;

- (instancetype)init {
    self = [super initWithNibName:NSStringFromClass([self class])
                           bundle:[NSBundle mainBundle]];
    if (self) {
        self.navigationController.title = @"Items";
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    tableData = [[PersistenceManager sharedInstance] loadItems];
    [self.tableView reloadData];
    
    self.tabBarController.navigationController.title = @"Items";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    Row *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[NSBundle mainBundle] loadNibNamed:@"Row" owner:self options:nil][0];
    }
    
    Item *item = [tableData objectAtIndex:indexPath.row];
    cell.name.text = item.name;
    cell.desc.text = item.desc;
    cell.thumbnail.image = item.image;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Item * item = [tableData objectAtIndex:indexPath.row];
    
    ItemDetailViewController *itemDetailViewController = [[ItemDetailViewController alloc] init];
    itemDetailViewController.item = item; // Set the exposed property
    [self.navigationController pushViewController:itemDetailViewController animated:YES];
    
}
@end
