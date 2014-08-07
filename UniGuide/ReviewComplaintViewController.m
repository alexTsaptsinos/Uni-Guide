//
//  ReviewComplaintViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "ReviewComplaintViewController.h"

@interface ReviewComplaintViewController ()

@end

@implementation ReviewComplaintViewController

@synthesize explanationLabel,concernLabel,commentsTextView,firstTimeTextEdit,selectTypeButton,courseKISCode,complaintCode,hasSelectedTypeOfComplaint;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIBarButtonItem *sendButton =[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendBtnPressed)];
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnPressed)];
        
        [self.navigationItem setLeftBarButtonItem:cancelButton];
        
        [self.navigationItem setRightBarButtonItem:sendButton];
        UILabel *reviewComplaintTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        reviewComplaintTitle.text = @"Report a Review";
        reviewComplaintTitle.backgroundColor = [UIColor clearColor];
        reviewComplaintTitle.textColor = [UIColor whiteColor];
        reviewComplaintTitle.font = [UIFont boldSystemFontOfSize:20.0];
        reviewComplaintTitle.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        reviewComplaintTitle.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = reviewComplaintTitle;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.explanationLabel.text = @"Provide more details about this review. The author of this review will not be able to see this report.";
    self.explanationLabel.numberOfLines = 0;
    self.explanationLabel.font = [UIFont fontWithName:@"Arial" size:14];
    self.commentsTextView.textColor = [UIColor grayColor];
    self.firstTimeTextEdit = YES;
    self.selectTypeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.selectTypeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.hasSelectedTypeOfComplaint = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.firstTimeTextEdit == YES) {
        self.commentsTextView.text = @"";
        self.commentsTextView.textColor = [UIColor blackColor];
        self.firstTimeTextEdit = NO;
        // self.reviewTextView.frame = CGRectMake(0, 203, 320, 60);
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.commentsTextView.frame = CGRectMake(0, 153, 320, 327);
}

- (void)textViewDidChange:(UITextView *)textView {
    self.commentsTextView.frame = CGRectMake(0, 153, 320, 110);
    
}

-(void)dismissKeyboard {
    [self.commentsTextView resignFirstResponder];
}

-(void) cancelBtnPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendBtnPressed
{
    if ([self.commentsTextView.text isEqualToString:@""] || firstTimeTextEdit == YES) {
        UIAlertView *noCommentsAlert = [[UIAlertView alloc] initWithTitle:@"Hold On There!" message:@"Please provide some comments" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noCommentsAlert show];
    }
    else if ([self.selectTypeButton.titleLabel.text isEqualToString:@"-Select Type-"]) {
        UIAlertView *noTypeAlert = [[UIAlertView alloc] initWithTitle:@"Hold On There!" message:@"Please select the type of concern" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noTypeAlert show];
    }
    else if (self.hasSelectedTypeOfComplaint == NO) {
        UIAlertView *noTypeAlert = [[UIAlertView alloc] initWithTitle:@"Hold On There!" message:@"Please select the type of concern" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noTypeAlert show];
    }
    else {
        PFObject *newComplaint = [PFObject objectWithClassName:@"ReviewComplaints"];
        newComplaint[@"Type"] = self.selectTypeButton.titleLabel.text;
        newComplaint[@"Comments"] = self.commentsTextView.text;
        newComplaint[@"CourseCode"] = self.courseKISCode;
        newComplaint[@"ReviewID"] = self.complaintCode;
        
        [newComplaint saveInBackground];
        
    [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectTypeButtonPressed:(id)sender {
    
    TypeOfComplaintsTableViewController *typeOfComplaintsTableViewController = [[TypeOfComplaintsTableViewController alloc] init];
    typeOfComplaintsTableViewController.previousView = self;
    
    UINavigationController *typeOfComplaintNavigationController = [[UINavigationController alloc]initWithRootViewController:typeOfComplaintsTableViewController];
    
    
    [self presentViewController:typeOfComplaintNavigationController animated:YES completion:nil];
}
@end
