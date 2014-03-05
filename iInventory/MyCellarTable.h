//
//  MyCellarTable.h
//  Winopedia
//
//  Created by Adrian Phillips on 5/18/13.
//  Copyright (c) 2013 Adrian Phillips. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
@interface MyCellarTable : UITableViewController<UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray *content;
@property (strong, nonatomic) NSArray *searchResults;
- (IBAction)add;
- (IBAction)showMenu;

@end
