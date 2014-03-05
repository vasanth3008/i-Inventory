//
//  MyCellarDetail1.h
//  Inventory
//
//  Created by Adrian Phillips on 2/6/14.
//  Copyright (c) 2014 Adrian Phillips. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCellarDetail1 : UIViewController{
    IBOutlet UIImageView *cityImage;
    IBOutlet UITextView *cityText;
    IBOutlet UILabel *cityName;
    IBOutlet UILabel *stateName;
    IBOutlet UILabel *price;
    NSString *cityImageString;
    NSString *cityTextString;
    NSString *cityNameString;
    NSString *stateNameString;
    NSString *priceString;
    
    
}

@property (nonatomic, retain) NSString *cityImageString;
@property (nonatomic, retain) NSString *cityTextString;
@property (nonatomic, retain) NSString *cityNameString;
@property (nonatomic, retain) NSString *stateNameString;
@property (nonatomic, retain) NSString *priceString;
@property (nonatomic, strong) UIImage* image;

@end
