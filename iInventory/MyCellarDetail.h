//
//  MyCellarDetail.h
//  Winopedia
//
//  Created by Adrian Phillips on 5/18/13.
//  Copyright (c) 2013 Adrian Phillips. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCellarDetail : UIViewController{
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
