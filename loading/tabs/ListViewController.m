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
#import "Worker.h"


@interface ListViewController ()
typedef void (^CompleteHandler)(void);
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.progressBar.progress = 0;
    self.progressBar.hidden = NO;
    
    [[Worker worker]createItems:^{
        NSLog(@"The items are ready");
    } withProgressBar: _progressBar];
   
    self.tabBarController.navigationController.title = @"Items";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateProgressBar:)
                                                 name: itemsCreated
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:itemsCreated
                                                  object:nil];
}

- (void) updateProgressBar: (NSNotification *) notification {
    NSNumber * progress = [notification object];
    self.progressBar.progress = [progress floatValue];
    if(self.progressBar.progress == 1) {
        [self loadItems];
    }
}

- (void) loadItems {
    tableData = [[PersistenceManager sharedInstance] loadItems];
    [self.tableView reloadData];
    self.progressBar.hidden = YES;
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
