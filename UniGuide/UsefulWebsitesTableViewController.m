//
//  UsefulWebsitesTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 24/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import "UsefulWebsitesTableViewController.h"

@interface UsefulWebsitesTableViewController ()

@end

@implementation UsefulWebsitesTableViewController

@synthesize websiteArray,websiteLinksArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationItem.title = @"Useful Websites";
    
    websiteArray = [[NSArray alloc] initWithObjects:@"UCAS",@"Student Room",@"QS Rankings",@"Save the Student!",@"NUS", nil];
    websiteLinksArray = [[NSArray alloc] initWithObjects:@"https://www.ucas.com/",@"http://www.thestudentroom.co.uk/",@"http://www.topuniversities.com/",@"http://www.savethestudent.org/",@"http://www.nus.org.uk/", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.websiteArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"UsefulWebsitesTableViewCell"];
    
    UsefulWebsitesTableViewCell *cell = (UsefulWebsitesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UsefulWebsitesTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *websiteImageView = [[UIImageView alloc] init];
    websiteImageView.image = [UIImage imageNamed:@"checked_checkbox.png"];
    //[[websiteImageView layer] setBorderWidth:2.0f];
    //[[websiteImageView layer] setBorderColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f].CGColor];
    websiteImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel *websiteNameLabel = [[UILabel alloc] init];
    websiteNameLabel.textColor = [UIColor colorWithRed:44.0f/255.0f green:61.0f/255.0f blue:76.0f/255.0f alpha:1.0f];
    websiteNameLabel.font = [UIFont fontWithName:@"Avenir-Black" size:22];
    websiteNameLabel.text = [self.websiteArray objectAtIndex:indexPath.row];

    UIButton *websiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    websiteButton.tag = indexPath.row;
    [websiteButton setTitle:@"Let's go!" forState:UIControlStateNormal];
    websiteButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [websiteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [websiteButton addTarget:self action:@selector(websiteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    websiteButton.exclusiveTouch = YES;
    [websiteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    websiteButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    CALayer *btnLayer = [websiteButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    //    [[extrasMenuButton layer] setBorderWidth:7.0f];
    //  [[extrasMenuButton layer] setBorderColor:[UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f].CGColor];
    
    UITextView *websiteTextView = [[UITextView alloc] init];
    websiteTextView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    websiteTextView.editable = NO;
    websiteTextView.scrollEnabled = NO;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineHeightMultiple = 17.0f;
    paragraphStyle.maximumLineHeight = 17.0f;
    paragraphStyle.minimumLineHeight = 17.0f;
    
    if (indexPath.row == 0) {
        
        NSString *string = @"Apply to UK universities through UCAS and track your application once it's started. Clearing information and advice on choosing a course also available on this great resource.";
        NSDictionary *attribute = @{
                                    NSParagraphStyleAttributeName : paragraphStyle,
                                    };
        websiteTextView.attributedText = [[NSAttributedString alloc] initWithString:string attributes:attribute];
        websiteImageView.image = [UIImage imageNamed:@"ucaslogo.png"];
        
    } else if (indexPath.row == 1) {
        
        NSString *string = @"The largest online student community where you can find a forum on almost anything, university related or not. Combined with pages of university application advice, this site is a must visit.";
        NSDictionary *attribute = @{
                                    NSParagraphStyleAttributeName : paragraphStyle,
                                    };
        websiteTextView.attributedText = [[NSAttributedString alloc] initWithString:string attributes:attribute];
        websiteImageView.image = [UIImage imageNamed:@"studentroom.png"];

        
    }   else if (indexPath.row == 2) {
        
        NSString *string = @"The QS World University Rankings have institutions ranked overall, by subject, faculty and region. Check out how your prospective universities match up with campuses worldwide.";
        NSDictionary *attribute = @{
                                    NSParagraphStyleAttributeName : paragraphStyle,
                                    };
        websiteTextView.attributedText = [[NSAttributedString alloc] initWithString:string attributes:attribute];
        websiteImageView.image = [UIImage imageNamed:@"qslogo.png"];

        
    }   else if (indexPath.row == 3) {
        
        NSString *string = @"Save the Student is the UKs most popular money saving site. They help students save money by hunting down the best deals, freebies & competitions plus publish tips on saving, making & managing your money!";
        NSDictionary *attribute = @{
                                    NSParagraphStyleAttributeName : paragraphStyle,
                                    };
        websiteTextView.attributedText = [[NSAttributedString alloc] initWithString:string attributes:attribute];
        websiteImageView.image = [UIImage imageNamed:@"sts-purple.png"];
        
    }   else {
        
        NSString *string = @"The national union of students take on issues that affect students' lives now and in the future. Providers of the NUS extra card for discounts across a multitude of stores nationwide.";
        NSDictionary *attribute = @{
                                    NSParagraphStyleAttributeName : paragraphStyle,
                                    };
        websiteTextView.attributedText = [[NSAttributedString alloc] initWithString:string attributes:attribute];
        websiteImageView.image = [UIImage imageNamed:@"nuslogo.png"];
        
    }
    
     websiteTextView.textColor = [UIColor colorWithRed:44.0f/255.0f green:61.0f/255.0f blue:76.0f/255.0f alpha:1.0f];
    [websiteTextView setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    
    CGFloat widthFloat = screenBound.size.width;
   // CGFloat heightFloat = screenBound.size.height - self.navigationController.navigationBar.frame.size.height - 20;
    
    if (indexPath.row % 2) {
        websiteImageView.frame = CGRectMake(widthFloat - 104, 4, 100, 100);
        websiteNameLabel.frame = CGRectMake(7, 5, 215, 25);
        websiteNameLabel.textAlignment = NSTextAlignmentLeft;
        [websiteButton setFrame:CGRectMake(widthFloat - 99, 120, 90, 45)];
        websiteTextView.frame = CGRectMake(5, 30, 210, 155);
        websiteTextView.textAlignment = NSTextAlignmentLeft;
    } else {
        websiteImageView.frame = CGRectMake(4, 4, 100, 100);
        websiteNameLabel.frame = CGRectMake(98, 5, 215, 25);
        websiteNameLabel.textAlignment = NSTextAlignmentRight;
        [websiteButton setFrame:CGRectMake(9, 120, 90, 45)];
        websiteTextView.frame = CGRectMake(105, 30, 210, 155);
        websiteTextView.textAlignment = NSTextAlignmentRight;
    }
    [cell addSubview:websiteImageView];
    [cell addSubview:websiteNameLabel];
    [cell addSubview:websiteButton];
    [cell addSubview:websiteTextView];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
    
    
}

- (void)websiteButtonClicked:(id)sender
{
    
    UIButton *btn = (UIButton *)sender;
    
    NSString *link = [self.websiteLinksArray objectAtIndex:btn.tag];
    NSLog(@"link: %@", link);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
    
    
}


@end
