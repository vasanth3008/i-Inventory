//
//  MyCellarAdd1.h
//  Inventory
//
//  Created by Adrian Phillips on 2/6/14.
//  Copyright (c) 2014 Adrian Phillips. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCellarAdd1 : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate>{
    
    IBOutlet UITextField *cityTextField;
    IBOutlet UITextField *stateTextField;
    IBOutlet UITextField *priceTextField;
    IBOutlet UITextView *cityDescription;
    
    UIImagePickerController* imagePicker;
}
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* name1;
@property (nonatomic, copy) NSString* name2;
@property (nonatomic, copy) NSString* description;
@property (nonatomic, strong) UIImage* image;
@property (nonatomic, retain) IBOutlet UINavigationBar* navigationBar;

@property (nonatomic, strong) UITextField *cityTextField;
@property (nonatomic, strong) UITextField *stateTextField;
@property (nonatomic, strong) UITextField *priceTextField;
@property (nonatomic, strong) UITextView *cityDescription;

@property (nonatomic, strong) IBOutlet UIButton* choosePhotoButton;
@property (nonatomic, strong) IBOutlet UIButton* takePhotoButton;
@property (nonatomic) CGRect originalTextViewFrame;



- (IBAction)save;
- (IBAction)cancel;

- (IBAction)choosePhoto;
- (IBAction)takePhoto;

@end