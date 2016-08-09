//
//  ListViewController.m
//  searchWithLib
//
//  Created by Ignacio Giagante on 9/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "ListViewController.h"
#import "Item.h"
#import "Row.h"
#import "MBProgressHUD.h"
#import "Loader.h"
#import "UIImageView+AFNetworking.h"

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
    
    self.isNewSearch = YES;
    
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.layer.zPosition = 1;

    // Regiser for HUD callbacks so we can remove it from the window at the right time
    self.HUD.delegate = self;
    
    self.HUD.label.text = @"Loading..";
    
    // get items from ML
    [[Loader loader] search:self.inputSearch];
    
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
    
    Item *item = [tableData objectAtIndex:indexPath.row];
    
    cell.title.text = item.title;
    cell.price.text = [NSString stringWithFormat:@"%0.2f", [item.price floatValue]];
    cell.myTag = indexPath.row;
    
    // load image async using UIImageView+AFNetworking
    [cell.thumbnail setImageWithURL:[NSURL URLWithString:item.thumbnail]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
