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

@synthesize titleTextField,nameTextField,reviewTextView,starButton1,starButton2,starButton3,starButton4,starButton5,firstTimeTextEdit,haveTheyRatedStars;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIBarButtonItem *sendButton =[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendBtnPressed)];
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnPressed)];
        
        [self.navigationItem setLeftBarButtonItem:cancelButton];
        
        [self.navigationItem setRightBarButtonItem:sendButton];
        
        
        self.navigationItem.title = @"Add Review";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
  //  self.reviewTextView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.firstTimeTextEdit = YES;
    self.reviewTextView.textColor = [UIColor grayColor];
    self.haveTheyRatedStars = NO;
    

    // Do any additional setup after loading the view from its nib.
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.firstTimeTextEdit == YES) {
        self.reviewTextView.text = @"";
        self.reviewTextView.textColor = [UIColor blackColor];
        self.firstTimeTextEdit = NO;
    }
    
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
        UIAlertView *noNameAlert = [[UIAlertView alloc] initWithTitle:@"Hold On There!" message:@"Please enter a name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noNameAlert show];
    }
    else if ([self.titleTextField.text isEqualToString:@""]) {
        UIAlertView *noTitleAlert = [[UIAlertView alloc] initWithTitle:@"Hold On There!" message:@"Please enter a title" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noTitleAlert show];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void) cancelBtnPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)starButton1Pressed:(id)sender {

    [self.starButton1 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateNormal];
    [self.starButton2 setImage:[UIImage imageNamed:@"favouritesButton"] forState:UIControlStateNormal];
    [self.starButton3 setImage:[UIImage imageNamed:@"favouritesButton"] forState:UIControlStateNormal];
    [self.starButton4 setImage:[UIImage imageNamed:@"favouritesButton"] forState:UIControlStateNormal];
    [self.starButton5 setImage:[UIImage imageNamed:@"favouritesButton"] forState:UIControlStateNormal];
    self.haveTheyRatedStars = YES;
}

- (IBAction)starButton2Pressed:(id)sender {
    [self.starButton1 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateNormal];
    [self.starButton2 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateNormal];
    [self.starButton3 setImage:[UIImage imageNamed:@"favouritesButton"] forState:UIControlStateNormal];
    [self.starButton4 setImage:[UIImage imageNamed:@"favouritesButton"] forState:UIControlStateNormal];
    [self.starButton5 setImage:[UIImage imageNamed:@"favouritesButton"] forState:UIControlStateNormal];
    self.haveTheyRatedStars = YES;
}

- (IBAction)starButton3Pressed:(id)sender {
    [self.starButton1 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateNormal];
    [self.starButton2 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateNormal];
    [self.starButton3 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateNormal];
    [self.starButton4 setImage:[UIImage imageNamed:@"favouritesButton"] forState:UIControlStateNormal];
    [self.starButton5 setImage:[UIImage imageNamed:@"favouritesButton"] forState:UIControlStateNormal];
    self.haveTheyRatedStars = YES;
}

- (IBAction)starButton4Pressed:(id)sender {
    [self.starButton1 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateNormal];
    [self.starButton2 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateNormal];
    [self.starButton3 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateNormal];
    [self.starButton4 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateNormal];
    [self.starButton5 setImage:[UIImage imageNamed:@"favouritesButton"] forState:UIControlStateNormal];
    self.haveTheyRatedStars = YES;
}

- (IBAction)starButton5Pressed:(id)sender {
    [self.starButton1 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateNormal];
    [self.starButton2 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateNormal];
    [self.starButton3 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateNormal];
    [self.starButton4 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateNormal];
    [self.starButton5 setImage:[UIImage imageNamed:@"favouritesButtonSelected"] forState:UIControlStateNormal];
    self.haveTheyRatedStars = YES;
}

@end
