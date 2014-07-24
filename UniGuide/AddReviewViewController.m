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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) sendBtnPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) cancelBtnPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
