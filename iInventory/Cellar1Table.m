//
//  Cellar1Table.m
//  Inventory
//
//  Created by Adrian Phillips on 2/6/14.
//  Copyright (c) 2014 Adrian Phillips. All rights reserved.
//

#import "Cellar1Table.h"
#import "MyCellarAdd1.h"
#import "MyCellarDetail1.h"

@interface Cellar1Table ()

@end

@implementation Cellar1Table
@synthesize content, searchResults;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)showMenu
{
    [self.frostedViewController presentMenuViewController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    content = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"]];
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:30.0/255.0f green:71.0/255.0f blue:103.0/255.0f alpha:1.0];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *filePath = [self plistFileDocumentPath:@"Data1.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:filePath];
    if (!exist) {
        return;
    }
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    content = dataArray;
    [self.tableView reloadData];
}

- (NSString *)plistFileDocumentPath:(NSString *)plistName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writablePath = [documentsDirectory stringByAppendingPathComponent:plistName];
    return writablePath;
}

- (IBAction)add;
{
    MyCellarAdd1* controller = [[MyCellarAdd1 alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
        
    } else {
        return [self.content count];
        
    }
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat: @"SELF['city'] BEGINSWITH[c] %@ ", searchText];
    
    searchResults = [content filteredArrayUsingPredicate:resultPredicate];
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller  didLoadSearchResultsTableView:(UITableView *)tableView
{
    tableView.rowHeight = 80.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    }
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor colorWithRed:30.0/255.0f green:71.0/255.0f blue:103.0/255.0f alpha:1.0];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [[searchResults objectAtIndex:indexPath.row] valueForKey:@"city"];
        cell.detailTextLabel.text = [[searchResults objectAtIndex:indexPath.row] valueForKey:@"state"];
        // Construct the expected URL for the image.
        NSURL *imageFileURL = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
        imageFileURL = [imageFileURL URLByAppendingPathComponent:[[self.searchResults objectAtIndex:indexPath.row] valueForKey:@"cityImage"] isDirectory:NO];
        // Attempt to load the image at the above URL.
        cell.imageView.image = [[UIImage alloc] initWithContentsOfFile:[imageFileURL path]];
        UIImageView * cityImage = (UIImageView *) [cell viewWithTag:102];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
        
        
        if (!cell.imageView.image)
            cityImage.image = [UIImage imageNamed:[[self.searchResults objectAtIndex:indexPath.row] valueForKey:@"cityImage"]];
    } else {
        
        UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
        nameLabel.text = [[self.content objectAtIndex:indexPath.row] valueForKey:@"city"];
        UILabel *stateLabel = (UILabel *)[cell viewWithTag:101];
        stateLabel.text = [[self.content objectAtIndex:indexPath.row] valueForKey:@"state"];
        // Construct the expected URL for the image.
        NSURL *imageFileURL = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
        imageFileURL = [imageFileURL URLByAppendingPathComponent:[[self.content objectAtIndex:indexPath.row] valueForKey:@"cityImage"] isDirectory:NO];
        // Attempt to load the image at the above URL.
        cell.imageView.image = [[UIImage alloc] initWithContentsOfFile:[imageFileURL path]];
        UIImageView * cityImage = (UIImageView *) [cell viewWithTag:102];
        
        if (!cell.imageView.image)
            cityImage.image = [UIImage imageNamed:[[self.content objectAtIndex:indexPath.row] valueForKey:@"cityImage"]];
        
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
        [self.content removeObjectAtIndex:indexPath.row];
        [self.content writeToFile:path atomically:YES];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    // remove object and insert at new position
    NSString *tmp = [[NSString alloc] initWithString:[self.content objectAtIndex:fromIndexPath.row]];
    [content removeObjectAtIndex:fromIndexPath.row];
    [content insertObject:tmp atIndex:toIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self performSegueWithIdentifier: @"showDetails1" sender: self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    if ([segue.identifier isEqualToString:@"showDetails1"]) {
        
        MyCellarDetail1 *DVC = [segue destinationViewController];
        if ([self.searchDisplayController isActive]) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            DVC.cityImageString = [[searchResults objectAtIndex:indexPath.row] valueForKey:@"cityImage"];
            DVC.cityTextString = [[searchResults objectAtIndex:indexPath.row] valueForKey:@"cityText"];
            DVC.cityNameString = [[searchResults objectAtIndex:indexPath.row] valueForKey:@"city"];
            DVC.stateNameString = [[searchResults objectAtIndex:indexPath.row] valueForKey:@"state"];
            DVC.priceString = [[searchResults objectAtIndex:indexPath.row] valueForKey:@"cityPrice"];
        } else {
            
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            DVC.cityTextString = [[self.content objectAtIndex:indexPath.row] valueForKey:@"cityText"];
            DVC.cityNameString = [[self.content objectAtIndex:indexPath.row] valueForKey:@"city"];
            DVC.stateNameString = [[self.content objectAtIndex:indexPath.row] valueForKey:@"state"];
            DVC.cityImageString = [[self.content objectAtIndex:indexPath.row] valueForKey:@"cityImage"];
            DVC.priceString = [[self.content objectAtIndex:indexPath.row] valueForKey:@"cityPrice"];
        }
    }
}

@end