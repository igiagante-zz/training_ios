//
//  ListViewController.m
//  searchLib
//
//  Created by Ignacio Giagante on 11/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "ListViewController.h"
#import "Row.h"
#import <searchLib/TKLoader.h>
#import <searchLib/TKItem.h>
#import "MBProgressHUD.h"

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString * inputSearch;

@property (strong, nonatomic) MBProgressHUD *HUD;
@property BOOL isNewSearch;

@end

@implementation ListViewController

NSArray *tableData;

- (instancetype) initWithData:(NSString *) inputSearch {
    self = [super init];
    if(self)
    {
        _inputSearch = inputSearch;
    }
    
    return self;
}
- (void) viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.layer.zPosition = 1;
    
    self.HUD.label.text = @"Loading..";
    
    // get items from ML
    [[TKLoader loader] search:self.inputSearch];
    
    // notify items are ready to load
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadItems:)
                                                 name: itemsLoaded
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:itemsLoaded
                                                  object:nil];
}

- (void) loadItems:(NSNotification *) notification {
    tableData = [notification object];
    [self.tableView reloadData];
    [self.HUD hideAnimated:TRUE];
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
    
    TKItem *item = [tableData objectAtIndex:indexPath.row];
    
    cell.title.text = item.title;
    cell.price.text = [NSString stringWithFormat:@"%0.2f", [item.price floatValue]];
    cell.myTag = indexPath.row;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^(void) {
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:item.thumbnail]];
        
        UIImage* image = [[UIImage alloc] initWithData:imageData];
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (cell.myTag == indexPath.row) {
                    cell.thumbnail.image = image;
                    [cell setNeedsLayout];
                }
            });
        }
    });
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end

