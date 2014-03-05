//
//  MenuViewController.m
//  Inventory
//
//  Created by Adrian Phillips on 2/6/14.
//  Copyright (c) 2014 Adrian Phillips. All rights reserved.
//

#import "MenuViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "InventoryNavigationController.h"
#import "MyCellarTable.h"
#import "HomeViewController.h"
#import "Cellar1Table.h"
#import "PrintingExampleViewController.h"


@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"bottle.jpg"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 5.0;//for complete circle change this value to 50
        imageView.layer.borderColor = [UIColor colorWithRed:30.0/255.0f green:71.0/255.0f blue:103.0/255.0f alpha:1.0].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        label.text = @"Adrian's Demo App";
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:30.0/255.0f green:71.0/255.0f blue:103.0/255.0f alpha:1.0];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if(section == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
        view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
        label.text = @"Section 1";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        [view addSubview:label];
		return @"Section 1";
    }if(section == 1){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
        view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
        label.text = @"Section 2";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        [view addSubview:label];
		return @"Section 2";
    }if(section == 2){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
        view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
        label.text = @"Section 3";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        [view addSubview:label];
		return @"Section 3";
    }
    return @"";
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor clearColor];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor colorWithRed:30.0/255.0f green:71.0/255.0f blue:103.0/255.0f alpha:1.0]];
    [header.textLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    //if (sectionIndex == 0)
    //    return 34;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    InventoryNavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeController"];
        navigationController.viewControllers = @[homeViewController];
    }if (indexPath.section == 0 && indexPath.row == 1) {
        MyCellarTable *tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tableController"];
        navigationController.viewControllers = @[tableViewController];
    } if (indexPath.section == 0 && indexPath.row == 2){
        Cellar1Table  *table1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"table1Controller"];
        navigationController.viewControllers = @[table1ViewController];
         } if (indexPath.section == 0 && indexPath.row == 3){
         PrintingExampleViewController *pdfViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pdfView"];
         navigationController.viewControllers = @[pdfViewController];
    }if (indexPath.section == 1 && indexPath.row == 0) {
        HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeController"];
        navigationController.viewControllers = @[homeViewController];
    } if (indexPath.section == 1 && indexPath.row == 1){
        Cellar1Table  *table1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"table1Controller"];
        navigationController.viewControllers = @[table1ViewController];
    }if (indexPath.section == 1 && indexPath.row == 2) {
        MyCellarTable *tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tableController"];
        navigationController.viewControllers = @[tableViewController];
         } if (indexPath.section == 1 && indexPath.row == 3){
         PrintingExampleViewController *pdfViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pdfView"];
         navigationController.viewControllers = @[pdfViewController];
    }if (indexPath.section == 2 && indexPath.row == 0) {
        HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeController"];
        navigationController.viewControllers = @[homeViewController];
    } if (indexPath.section == 2 && indexPath.row == 1){
        Cellar1Table  *table1ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"table1Controller"];
        navigationController.viewControllers = @[table1ViewController];
    }if (indexPath.section == 2 && indexPath.row == 2) {
        MyCellarTable *tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tableController"];
        navigationController.viewControllers = @[tableViewController];
         } if (indexPath.section == 2 && indexPath.row == 3){
         PrintingExampleViewController *pdfViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pdfView"];
         navigationController.viewControllers = @[pdfViewController];
    }
    
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        NSArray *titles = @[@"Home", @"Cellar 1", @"Cellar 2", @"PDF"];
        cell.textLabel.text = titles[indexPath.row];
    } if (indexPath.section == 1){
        NSArray *titles = @[@"Home", @"Cellar 1", @"Cellar 2", @"PDF"];
        cell.textLabel.text = titles[indexPath.row];
    } if (indexPath.section == 2){
        NSArray *titles = @[@"Home", @"Cellar 1", @"Cellar 2", @"PDF"];
        cell.textLabel.text = titles[indexPath.row];
    }
    
    
    return cell;
}

@end
