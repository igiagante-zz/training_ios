//
//  ListViewController.m
//  search
//
//  Created by Ignacio Giagante on 4/8/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "ListViewController.h"
#import "Item.h"
#import "Row.h"
#import "Loader.h"
#import "AFNetworking.h"

@interface ListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (strong, nonatomic) NSString * inputSearch;

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.progressBar.progress = 0;
    self.progressBar.hidden = NO;
    
    // get items from ML
    [[Loader loader] search:self.inputSearch];
    
    // notify the progress of retreiving items
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateProgressBar:)
                                                 name: itemCreated
                                               object:nil];
    
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
                                                    name:itemCreated
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:itemsLoaded
                                                  object:nil];
}

- (void) updateProgressBar: (NSNotification *) notification {
    NSNumber * progress = [notification object];
    self.progressBar.progress = [progress floatValue];
    if(self.progressBar.progress == 1) {
        self.progressBar.hidden = YES;
    }
}

- (void) loadItems:(NSNotification *) notification {
    tableData = [notification object];
    [self.tableView reloadData];
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
    //cell.price.text = [NSString stringWithFormat:@"%@", item.price];
    cell.price.text = [NSString stringWithFormat:@"%0.2f", [item.price floatValue]];
    cell.myTag = indexPath.row;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^(void) {
        
     NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:item.thumbnail]];
                             
        UIImage* image = [[UIImage alloc] initWithData:imageData];
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (cell.myTag == indexPath.row) {
                    cell.imageView.image = image;
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

