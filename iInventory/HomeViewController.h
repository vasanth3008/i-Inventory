//
//  HomeViewController.h
//  Inventory
//
//  Created by Adrian Phillips on 2/6/14.
//  Copyright (c) 2014 Adrian Phillips. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface HomeViewController : UIViewController
@property (nonatomic, strong) IBOutlet UITextView *tView;
- (IBAction)showMenu;

@end
