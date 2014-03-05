//
//  TPKeyboardAvoidingScrollView.h
//
//  Created by Michael Tyson on 11/04/2011.
//  Copyright 2011 A Tasty Pixel. All rights reserved.
//  Free for commercial use and redistribution in any form. Credit is appreciated but not essential. Oh, and there aint no warranty!

// Michael Tyson, A Tasty Pixel
// michael@atastypixel.com

#import <UIKit/UIKit.h>

@interface TPKeyboardAvoidingScrollView : UIScrollView
- (BOOL)focusNextTextField;
- (void)scrollToActiveTextField;
@end
