//
//  PrintingExampleViewController.m
//  TestApplication
//
//  Created by Adrian Phillips on 2/21/14.
//  Copyright (c) 2014 Adrian Phillips. All rights reserved.
//

#import "PrintingExampleViewController.h"


#define kDefaultPageHeight 792
#define kDefaultPageWidth  612
#define kMargin 50
#define kColumnMargin 10

@implementation PrintingExampleViewController
@synthesize pdfFilePath;

- (IBAction)showMenu
{
    [self.frostedViewController presentMenuViewController];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)pdfPressed:(id)sender {
    
    
    // create some sample data. In a real application, this would come from the database or an API.
    NSString* path = [[NSBundle mainBundle] pathForResource:@"sampleData" ofType:@"plist"];
    NSDictionary* data = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray* students = [data objectForKey:@"Students"];
    
    // get a temprorary filename for this PDF
    path = NSTemporaryDirectory();
    self.pdfFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%f.pdf", [[NSDate date] timeIntervalSince1970] ]];
    
    // Create the PDF context using the default page size of 612 x 792.
    // This default is spelled out in the iOS documentation for UIGraphicsBeginPDFContextToFile
    UIGraphicsBeginPDFContextToFile(self.pdfFilePath, CGRectZero, nil);
    
    // get the context reference so we can render to it.
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    int currentPage = 0;
    
    // maximum height and width of the content on the page, byt taking margins into account.
    CGFloat maxWidth = kDefaultPageWidth - kMargin * 2;
    CGFloat maxHeight = kDefaultPageHeight - kMargin * 2;
    
    // we're going to cap the name of the class to using half of the horizontal page, which is why we're dividing by 2
    CGFloat classNameMaxWidth = maxWidth / 2;
    
    // the max width of the grade is also half, minus the margin
    CGFloat gradeMaxWidth = (maxWidth / 2) - kColumnMargin;
    
    
    // only create the fonts once since it is a somewhat expensive operation
    UIFont* studentNameFont = [UIFont boldSystemFontOfSize:17];
    UIFont* classFont = [UIFont systemFontOfSize:15];
    
    CGFloat currentPageY = 0;
    
    // iterate through out students, adding to the pdf each time.
    for (NSDictionary* student in students)
    {
        // every student gets their own page
        // Mark the beginning of a new page.
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, kDefaultPageWidth, kDefaultPageHeight), nil);
        currentPageY = kMargin;
        
        // draw the student's name at the top of the page.
        NSString* name = [NSString stringWithFormat:@"%@ %@",
                          [student objectForKey:@"FirstName"],
                          [student objectForKey:@"LastName"]];
        
        CGSize size = [name sizeWithFont:studentNameFont forWidth:maxWidth lineBreakMode:NSLineBreakByWordWrapping];
        [name drawAtPoint:CGPointMake(kMargin, currentPageY) forWidth:maxWidth withFont:studentNameFont lineBreakMode:NSLineBreakByWordWrapping];
        currentPageY += size.height;
        
        // draw a one pixel line under the student's name
        CGContextSetStrokeColorWithColor(context, [[UIColor blueColor] CGColor]);
        CGContextMoveToPoint(context, kMargin, currentPageY);
        CGContextAddLineToPoint(context, kDefaultPageWidth - kMargin, currentPageY);
        CGContextStrokePath(context);
        
        // iterate through the list of classes and add these to the PDF.
        NSArray* classes = [student objectForKey:@"Classes"];
        for(NSDictionary* class in classes)
        {
            NSString* className = [class objectForKey:@"Name"];
            NSString* grade = [class objectForKey:@"Grade"];
            
            // before we render any text to the PDF, we need to measure it, so we'll know where to render the
            // next line.
            size = [className sizeWithFont:classFont constrainedToSize:CGSizeMake(classNameMaxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            // if the current text would render beyond the bounds of the page,
            // start a new page and render it there instead
            if (size.height + currentPageY > maxHeight) {
                // create a new page and reset the current page's Y value
                UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, kDefaultPageWidth, kDefaultPageHeight), nil);
                currentPageY = kMargin;
            }
            
            // render the text
            [className drawInRect:CGRectMake(kMargin, currentPageY, classNameMaxWidth, maxHeight) withFont:classFont lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
            
            // print the grade to the right of the class name
            [grade drawInRect:CGRectMake(kMargin + classNameMaxWidth + kColumnMargin, currentPageY, gradeMaxWidth, maxHeight) withFont:classFont lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
            
            currentPageY += size.height;
            
        }
        
        
        // increment the page number.
        currentPage++;
        
    }
    
    // end and save the PDF.
    UIGraphicsEndPDFContext();
    
    // Ask the user if they'd like to see the file or email it.
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"Would you like to preview or email this PDF?"
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"Preview", @"Email", nil];
    [actionSheet showInView:self.view];
    
    
    
    
    
}

#pragma mark - MFMailComposerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        // present a preview of this PDF File.
        QLPreviewController* preview = [[QLPreviewController alloc] init];
        preview.dataSource = self;
        [self presentViewController:preview animated:YES completion:nil];
        
    }
    else if(buttonIndex == 1)
    {
        // email the PDF File.
        MFMailComposeViewController* mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer addAttachmentData:[NSData dataWithContentsOfFile:self.pdfFilePath]
                               mimeType:@"application/pdf" fileName:@"report.pdf"];
        
        [self presentViewController:mailComposer animated:YES completion:nil];
    }
    
}

#pragma mark - QLPreviewControllerDataSource
- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller
{
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    return [NSURL fileURLWithPath:self.pdfFilePath];
}

@end