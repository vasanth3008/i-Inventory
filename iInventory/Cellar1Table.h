//
//  Cellar1Table.h
//  Inventory
//
//  Created by Adrian Phillips on 2/6/14.
//  Copyright (c) 2014 Adrian Phillips. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface Cellar1Table : UITableViewController<UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray *content;
@property (strong, nonatomic) NSArray *searchResults;
- (IBAction)add;
- (IBAction)showMenu;
@end