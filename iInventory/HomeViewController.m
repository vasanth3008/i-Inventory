//
//  HomeViewController.m
//  Inventory
//
//  Created by Adrian Phillips on 2/6/14.
//  Copyright (c) 2014 Adrian Phillips. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tView.text = @"this is the initial text introducing the app and how it works. there shopuld be an elaborated text to introduce the app. the main functions need to be displayed and all the info needs to be displayed here. this view is the first view that the client interacts with so it should be very discriptive.";
    //[self.tView setBackgroundColor:[UIColor clearColor]];
    //[[self.tView layer] setBorderColor:[[UIColor clearColor] CGColor]];
    [self.tView setFont:[UIFont fontWithName:@"Marker felt" size:20]];
    //[[self.tView layer] setBorderWidth:2];
    //[[self.tView layer] setCornerRadius:15];
    //[self.tView setClipsToBounds: YES];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:30.0/255.0f green:71.0/255.0f blue:103.0/255.0f alpha:1.0];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
}

- (IBAction)showMenu
{
    [self.frostedViewController presentMenuViewController];
}

@end
