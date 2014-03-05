//
//  PrintingExampleViewController.h
//  TestApplication
//
//  Created by Adrian Phillips on 2/21/14.
//  Copyright (c) 2014 Adrian Phillips. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <QuickLook/QuickLook.h>
#import "REFrostedViewController.h"
@interface PrintingExampleViewController : UIViewController <MFMailComposeViewControllerDelegate, UIActionSheetDelegate, QLPreviewControllerDataSource>{
    
    NSString* pdfFilePath;
}

- (IBAction)pdfPressed:(id)sender;
- (IBAction)showMenu;
@property (nonatomic, retain) NSString* pdfFilePath;

@end