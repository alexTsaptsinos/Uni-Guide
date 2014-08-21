//
//  AddReviewViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "AddReviewViewController.h"

@interface AddReviewViewController ()

@end

@implementation AddReviewViewController

@synthesize titleTextField,nameTextField,reviewTextView,starButton1,starButton2,starButton3,starButton4,starButton5,firstTimeTextEdit,haveTheyRatedStars,couseKISCode,howManyStars,selectYearButton,haveTheySelectedYear;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIBarButtonItem *sendButton =[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendBtnPressed)];
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnPressed)];
        
        [self.navigationItem setLeftBarButtonItem:cancelButton];
        
        [self.navigationItem setRightBarButtonItem:sendButton];
        
        
        UILabel *addReviewTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        addReviewTitle.text = @"Add Review";
        addReviewTitle.backgroundColor = [UIColor clearColor];
        addReviewTitle.textColor = [UIColor whiteColor];
        addReviewTitle.font = [UIFont boldSystemFontOfSize:20.0];
        addReviewTitle.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        addReviewTitle.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = addReviewTitle;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.firstTimeTextEdit = YES;
    self.reviewTextView.textColor = [UIColor grayColor];
    self.haveTheyRatedStars = NO;
    self.selectYearButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.haveTheySelectedYear = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

    // Do any additional setup after loading the view from its nib.
}

-(void)dismissKeyboard {
    [self.reviewTextView resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.firstTimeTextEdit == YES) {
        self.reviewTextView.text = @"";
        self.reviewTextView.textColor = [UIColor blackColor];
        self.firstTimeTextEdit = NO;
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.reviewTextView.frame = CGRectMake(0, 203, 320, 277);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.titleTextField) {
        [textField resignFirstResponder];
    }
    if (textField == self.nameTextField) {
        [textField resignFirstResponder];
    }

    return YES;
}

-(void) sendBtnPressed
{
    if (self.haveTheyRatedStars == NO) {
        UIAlertView *noRatingAlert = [[UIAlertView alloc] initWithTitle:@"Hold On There!" message:@"Please rate the course" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noRatingAlert show];
    }
    else if ([self.nameTextField.text isEqualToString:@""]) {
        UIAlertView *noNameAlert = [[UIAlertView alloc] initWithTitle:@"Hold On There!" message:@"Please enter a nickname" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noNameAlert show];
    }
    else if ([self.titleTextField.text isEqualToString:@""]) {
        UIAlertView *noTitleAlert = [[UIAlertView alloc] initWithTitle:@"Hold On There!" message:@"Please enter a title" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noTitleAlert show];
    }
    else if (self.haveTheySelectedYear == NO) {
        UIAlertView *noYearAlert = [[UIAlertView alloc] initWithTitle:@"Hold On There!" message:@"Please enter your year" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noYearAlert show];
    }
    else {
        NSURL *scriptUrl = [NSURL URLWithString:@"http://google.com"];
        NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
        
        if (data) {
            PFObject *newReview = [PFObject objectWithClassName:@"CourseReviews"];
            newReview[@"ReviewerName"] = self.nameTextField.text;
            newReview[@"ReviewTitle"] = self.titleTextField.text;
            newReview[@"ReviewText"] = self.reviewTextView.text;
            newReview[@"CourseCode"] = self.couseKISCode;
            newReview[@"StarRating"] = self.howManyStars;
            newReview[@"ReviewerYear"] = self.selectYearButton.titleLabel.text;
            [newReview saveInBackground];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSLog(@"no internet");
            UIAlertView *noInternetAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You appear to have no internet connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [noInternetAlert show];
        }
        
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    self.reviewTextView.frame = CGRectMake(0, 203, 320, 60);

}

-(void) cancelBtnPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)starButton1Pressed:(id)sender {

    [self.starButton1 setImage:[UIImage imageNamed:@"star-27"] forState:UIControlStateNormal];
    [self.starButton2 setImage:[UIImage imageNamed:@"star-26"] forState:UIControlStateNormal];
    [self.starButton3 setImage:[UIImage imageNamed:@"star-26"] forState:UIControlStateNormal];
    [self.starButton4 setImage:[UIImage imageNamed:@"star-26"] forState:UIControlStateNormal];
    [self.starButton5 setImage:[UIImage imageNamed:@"star-26"] forState:UIControlStateNormal];
    [self.reviewTextView resignFirstResponder];
    self.howManyStars = [NSNumber numberWithInt:1];
    self.haveTheyRatedStars = YES;
}

- (IBAction)starButton2Pressed:(id)sender {
    [self.starButton1 setImage:[UIImage imageNamed:@"star-27"] forState:UIControlStateNormal];
    [self.starButton2 setImage:[UIImage imageNamed:@"star-27"] forState:UIControlStateNormal];
    [self.starButton3 setImage:[UIImage imageNamed:@"star-26"] forState:UIControlStateNormal];
    [self.starButton4 setImage:[UIImage imageNamed:@"star-26"] forState:UIControlStateNormal];
    [self.starButton5 setImage:[UIImage imageNamed:@"star-26"] forState:UIControlStateNormal];
    [self.reviewTextView resignFirstResponder];
    self.howManyStars = [NSNumber numberWithInt:2];
    self.haveTheyRatedStars = YES;
}

- (IBAction)starButton3Pressed:(id)sender {
    [self.starButton1 setImage:[UIImage imageNamed:@"star-27"] forState:UIControlStateNormal];
    [self.starButton2 setImage:[UIImage imageNamed:@"star-27"] forState:UIControlStateNormal];
    [self.starButton3 setImage:[UIImage imageNamed:@"star-27"] forState:UIControlStateNormal];
    [self.starButton4 setImage:[UIImage imageNamed:@"star-26"] forState:UIControlStateNormal];
    [self.starButton5 setImage:[UIImage imageNamed:@"star-26"] forState:UIControlStateNormal];
    [self.reviewTextView resignFirstResponder];
    self.howManyStars = [NSNumber numberWithInt:3];
    self.haveTheyRatedStars = YES;
}

- (IBAction)starButton4Pressed:(id)sender {
    [self.starButton1 setImage:[UIImage imageNamed:@"star-27"] forState:UIControlStateNormal];
    [self.starButton2 setImage:[UIImage imageNamed:@"star-27"] forState:UIControlStateNormal];
    [self.starButton3 setImage:[UIImage imageNamed:@"star-27"] forState:UIControlStateNormal];
    [self.starButton4 setImage:[UIImage imageNamed:@"star-27"] forState:UIControlStateNormal];
    [self.starButton5 setImage:[UIImage imageNamed:@"star-26"] forState:UIControlStateNormal];
    [self.reviewTextView resignFirstResponder];
    self.howManyStars = [NSNumber numberWithInt:4];
    self.haveTheyRatedStars = YES;
}

- (IBAction)starButton5Pressed:(id)sender {
    [self.starButton1 setImage:[UIImage imageNamed:@"star-27"] forState:UIControlStateNormal];
    [self.starButton2 setImage:[UIImage imageNamed:@"star-27"] forState:UIControlStateNormal];
    [self.starButton3 setImage:[UIImage imageNamed:@"star-27"] forState:UIControlStateNormal];
    [self.starButton4 setImage:[UIImage imageNamed:@"star-27"] forState:UIControlStateNormal];
    [self.starButton5 setImage:[UIImage imageNamed:@"star-27"] forState:UIControlStateNormal];
    [self.reviewTextView resignFirstResponder];
    self.howManyStars = [NSNumber numberWithInt:5];
    self.haveTheyRatedStars = YES;
}

- (IBAction)selectYearButtonPressed:(id)sender {
    
    WhatYearForNewReviewTableViewController *whatYearForNewReviewTableViewController = [[WhatYearForNewReviewTableViewController alloc] init];
    whatYearForNewReviewTableViewController.previousViewController = self;
    
    UINavigationController *whatyearNavigationController = [[UINavigationController alloc]initWithRootViewController:whatYearForNewReviewTableViewController];
    
    
    [self presentViewController:whatyearNavigationController animated:YES completion:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 30) ? NO : YES;
}

@end
