//
//  AddReviewViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "WhatYearForNewReviewTableViewController.h"

@interface AddReviewViewController : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *selectYearButton;
- (IBAction)selectYearButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *reviewTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIButton *starButton1;
@property (weak, nonatomic) IBOutlet UIButton *starButton2;
@property (weak, nonatomic) IBOutlet UIButton *starButton3;
@property (weak, nonatomic) IBOutlet UIButton *starButton4;
@property (weak, nonatomic) IBOutlet UIButton *starButton5;
- (IBAction)starButton1Pressed:(id)sender;
- (IBAction)starButton2Pressed:(id)sender;
- (IBAction)starButton3Pressed:(id)sender;
- (IBAction)starButton4Pressed:(id)sender;
- (IBAction)starButton5Pressed:(id)sender;
@property (nonatomic) BOOL firstTimeTextEdit;
@property (nonatomic) BOOL haveTheyRatedStars;
@property (nonatomic) BOOL haveTheySelectedYear;
@property (nonatomic,strong) NSString *couseKISCode;
@property (nonatomic) NSNumber *howManyStars;


@end
