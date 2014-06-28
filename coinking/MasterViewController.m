//
//  MasterViewController.m
//  coinking
//
//  Created by CG3 on 6/26/14.
//  Copyright (c) 2014 CoinKing.io. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
    NSDictionary *algorithms;
    NSArray *algorithmSectionTitles;
    NSMutableArray *nowMiningArray;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:@"https://coinking.io/api.php?key=9f5671cf0a4bc9007fd9aa81a23e8c24&type=currentlymining&output=json"];   // pass your URL  Here.
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSLog(@"%@", json);
    
    nowMiningArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *restaurantParameters in json)
    {
        [nowMiningArray addObject:restaurantParameters];
    }
    
    algorithms = @{
                   @"Scrypt" : @[[[nowMiningArray[0] objectForKey:@"name"] capitalizedString],
                                 [NSString stringWithFormat:@"Hashrate: %@ MH/s", [nowMiningArray[0] objectForKey:@"hashrate"]],
                                 [NSString stringWithFormat:@"Difficulty: %@", [nowMiningArray[0] objectForKey:@"difficulty"]]],
                    @"Scrypt-N" : @[[[nowMiningArray[1] objectForKey:@"name"] capitalizedString],
                                    [NSString stringWithFormat:@"Hashrate: %@ MH/s", [nowMiningArray[1] objectForKey:@"hashrate"]],
                                    [NSString stringWithFormat:@"Difficulty: %@", [nowMiningArray[1] objectForKey:@"difficulty"]]],
                   @"SHA-256" : @[[[nowMiningArray[2] objectForKey:@"name"] capitalizedString],
                                  [NSString stringWithFormat:@"Hashrate: %@ MH/s", [nowMiningArray[2] objectForKey:@"hashrate"]],
                                  [NSString stringWithFormat:@"Difficulty: %@", [nowMiningArray[2] objectForKey:@"difficulty"]]],
                   @"X11" : @[[[nowMiningArray[3] objectForKey:@"name"] capitalizedString],
                              [NSString stringWithFormat:@"Hashrate: %@ MH/s", [nowMiningArray[3] objectForKey:@"hashrate"]],
                              [NSString stringWithFormat:@"Difficulty: %@", [nowMiningArray[3] objectForKey:@"difficulty"]]],
                   @"X13" : @[[[nowMiningArray[4] objectForKey:@"name"] capitalizedString],
                              [NSString stringWithFormat:@"Hashrate: %@ MH/s", [nowMiningArray[4] objectForKey:@"hashrate"]],
                              [NSString stringWithFormat:@"Difficulty: %@", [nowMiningArray[4] objectForKey:@"difficulty"]]]
                   };
    algorithmSectionTitles = [[algorithms allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(NSString *)name value:(NSString *)value inSection:(NSInteger)section
{
    if (!_objects)
    {
        _objects = [[NSMutableArray alloc] init];
    }
    NSString *result = [NSString stringWithFormat:@"%@: %@", name, value];
    [_objects insertObject:result atIndex:0];
    NSLog(@"%d", _objects.count);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [algorithmSectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [algorithmSectionTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *sectionTitle = [algorithmSectionTitles objectAtIndex:section];
    NSArray *sectionAlgorithms = [algorithms objectForKey:sectionTitle];
    return [sectionAlgorithms count];
}

/*
UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
UIImage *coinImage = [UIImage imageWithData:
                      [NSData dataWithContentsOfURL:
                       [NSURL URLWithString:[NSString stringWithFormat:@"https://coinking.io/assets/coins/large-%@.png", name]]]];
imgView.image = coinImage;
cell.imageView.image = imgView.image;
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *sectionTitle = [algorithmSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionAlgorithms = [algorithms objectForKey:sectionTitle];
    NSString *cellText = [sectionAlgorithms objectAtIndex:indexPath.row];
    
    cell.textLabel.text = cellText;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    UIImage *coinImage = [UIImage imageWithData:
                          [NSData dataWithContentsOfURL:
                           [NSURL URLWithString:
                            [NSString stringWithFormat:@"https://coinking.io/assets/coins/large-%@.png", [cellText lowercaseString]
                             ]
                            ]
                           ]
                          ];
    imgView.image = coinImage;
    cell.imageView.image = imgView.image;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
