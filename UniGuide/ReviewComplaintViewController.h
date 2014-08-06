//
//  ReviewComplaintViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeOfComplaintsTableViewController.h"
#import <Parse/Parse.h>

@interface ReviewComplaintViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *explanationLabel;
@property (weak, nonatomic) IBOutlet UILabel *concernLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentsTextView;
@property (nonatomic,strong) NSString *courseKISCode;
@property (nonatomic) BOOL firstTimeTextEdit;
@property (nonatomic) BOOL hasSelectedTypeOfComplaint;
@property (weak, nonatomic) IBOutlet UIButton *selectTypeButton;
@property (strong, nonatomic) NSString *complaintCode;
- (IBAction)selectTypeButtonPressed:(id)sender;


@end
