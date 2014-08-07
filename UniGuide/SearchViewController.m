//
//  SearchViewController.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 19/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultsTableViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize universityTextField,universitiesFromParse,autocompleteUniversities,autocompleteUniversitiesTableView,courseTextField,scrollView,whichTextFieldActive,coursesFromParse,locationTextField,searchButton,locationsArray,pleaseSelectLabel,anyFound,locationDict,universityUKPRNFromParse,haveQueriedParseForCoursesYet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //give navigation bar title
    self.navigationItem.title = @"Search";
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.searchButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    [searchButton setEnabled:NO];
    self.pleaseSelectLabel.textColor = [UIColor grayColor];
    self.pleaseSelectLabel.text = @"Please select from at least two fields";
    [pleaseSelectLabel setFont:[UIFont systemFontOfSize:12]];
    
    CALayer *btnLayer = [searchButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    self.haveQueriedParseForCoursesYet = NO;
    
    //Query for universities and locations
    
    PFQuery *universityQuery = [PFQuery queryWithClassName:@"Institution1213"];
    [universityQuery setLimit:161];
     [universityQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
        self.universitiesFromParse = [objects valueForKey:@"Institution"];
         self.universityUKPRNFromParse = [objects valueForKey:@"UKPRN"];
         //NSLog(@"ukprns: %@ count: %d",self.universityUKPRNFromParse,self.universityUKPRNFromParse.count);
     }];
    
    self.locationDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"East Of England", @"EAST", @"West Midlands", @"WMID",@"South West",@"SWES",@"London",@"LOND",@"East Midlands",@"EMID",@"North West",@"NWES",@"Yorkshire And The Humber",@"YORH",@"South East",@"SEAS", @"North East",@"NEAS",@"Wales",@"WALE",@"Scotland",@"SCOT",@"Northern Ireland",@"NIRE",nil];
    
    //self.locationsFromParse = [dict objectsForKeys:@"EAST",@"WMID",@"SWES",@"LOND",@"EMID",@"NWES",@"YORH",@"SEAS",@"NEAS",@"WALE",@"SCOT",@"NIRE" notFoundMarker:nil];
    self.locationsArray = [self.locationDict allValues];
    
    self.autocompleteUniversities = [[NSMutableArray alloc] init];
    
    autocompleteUniversitiesTableView = [[UITableView alloc] initWithFrame:
                             CGRectMake(0, 40, 320, 200) style:UITableViewStylePlain];
    autocompleteUniversitiesTableView.delegate = self;
    autocompleteUniversitiesTableView.dataSource = self;
    autocompleteUniversitiesTableView.scrollEnabled = YES;
    autocompleteUniversitiesTableView.hidden = YES;
    autocompleteUniversitiesTableView.rowHeight = 35;
    autocompleteUniversitiesTableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    [self.view addSubview:autocompleteUniversitiesTableView];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.searchButton setEnabled:NO];
    self.pleaseSelectLabel.hidden = NO;
    
    if (textField == self.universityTextField) {
        [self.scrollView setContentOffset:CGPointMake(0.0,12) animated:YES];
        self.whichTextFieldActive = [NSNumber numberWithInt:1];
    }
    if (textField == self.courseTextField) {
        [self.scrollView setContentOffset:CGPointMake(0.0,80) animated:YES];
        self.whichTextFieldActive = [NSNumber numberWithInt:2];
    }
    if (textField == self.locationTextField) {
        [self.scrollView setContentOffset:CGPointMake(0.0,153) animated:YES];
        self.whichTextFieldActive = [NSNumber numberWithInt:3];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.universityTextField) {
        [self.scrollView setContentOffset:CGPointMake(0.0,-6) animated:YES];
    }
    if (textField == self.courseTextField) {
        [self.scrollView setContentOffset:CGPointMake(0.0, -6) animated:YES];
    }
    if (textField == self.locationTextField) {
        [self.scrollView setContentOffset:CGPointMake(0.0,-6) animated:YES];
    }
    if ((self.courseTextField.text.length != 0 && self.locationTextField.text.length !=0) || (self.courseTextField.text.length != 0 && self.universityTextField.text.length !=0) || (self.universityTextField.text.length != 0 && self.locationTextField.text.length !=0))  {
        [self.searchButton setEnabled:YES];
        self.pleaseSelectLabel.hidden = YES;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return autocompleteUniversities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteUniversitiesRowIdentifier = @"AutoCompleteUniversitiesRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteUniversitiesRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteUniversitiesRowIdentifier];
    }
    
    if (self.anyFound == NO) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [autocompleteUniversities objectAtIndex:indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.numberOfLines = 0;
    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    return cell;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    autocompleteUniversitiesTableView.hidden = NO;
    
    NSString *substring = [NSString stringWithString:textField.text];
    //NSLog(@"%@", substring);
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    //NSLog(@"%@", substring);
    if (substring.length == 0) {
        autocompleteUniversitiesTableView.hidden = YES;
    } else {
    [self filterUniversitiesForSearchText:substring];
    }
    
    return YES;
}

- (void)filterUniversitiesForSearchText:(NSString*)searchText
{
    //NSLog(@"which text field: %@", self.whichTextFieldActive);
    
    NSPredicate *universitiesPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    
    if ([self.whichTextFieldActive intValue] == 1) {
        self.autocompleteUniversities = [universitiesFromParse filteredArrayUsingPredicate:universitiesPredicate];
    } else if ([self.whichTextFieldActive intValue] == 2) {
        
        if (self.courseTextField.text.length < 4) {
            
            self.autocompleteUniversities = [[NSMutableArray alloc] initWithObjects:@"Please Enter More Letters", nil];
            self.haveQueriedParseForCoursesYet = NO;
            
        } else {
        
        [self parseQueryForCourses:searchText];
        self.autocompleteUniversities = [coursesFromParse filteredArrayUsingPredicate:universitiesPredicate];
        }
        
        
    } else if ([self.whichTextFieldActive intValue] == 3) {
        self.autocompleteUniversities = [locationsArray filteredArrayUsingPredicate:universitiesPredicate];
    }
    
    
    if (self.autocompleteUniversities.count == 0) {
        self.autocompleteUniversities = [[NSMutableArray alloc] initWithObjects:@"None", nil];
        self.anyFound = NO;
    } else {
        self.anyFound = YES;
    }
    
    [autocompleteUniversitiesTableView reloadData];
}

- (void)parseQueryForCourses:(NSString *)searchText
{
    if (self.haveQueriedParseForCoursesYet == NO) {
        
        PFQuery *coursesQuery = [PFQuery queryWithClassName:@"Kiscourse"];
        [coursesQuery setLimit:1000];
        [coursesQuery whereKeyExists:@"TITLE"];
        //NSLog(@"test: %@",self.universityUKPRNFromParse);
        [coursesQuery whereKey:@"TITLE" matchesRegex:searchText modifiers:@"i"];
        [coursesQuery whereKeyExists:@"TITLE"];
        if (self.universityTextField.text.length != 0) {
            PFQuery *queryForUKPRN = [PFQuery queryWithClassName:@"Institution1213"];
            [queryForUKPRN whereKey:@"Institution" matchesRegex:self.universityTextField.text modifiers:@"i"];
            [queryForUKPRN selectKeys:[NSArray arrayWithObject:@"UKPRN"]];
            PFObject *tempObject = [queryForUKPRN getFirstObject];
            NSString *ukprn = [tempObject valueForKey:@"UKPRN"];
            NSLog(@"object: %@, ukprn: %@",tempObject,ukprn);
            if (ukprn.length != 0) {
                [coursesQuery whereKey:@"UKPRN" equalTo:ukprn];
                NSLog(@"got here");
            }
        }
        [coursesQuery selectKeys:[NSArray arrayWithObject:@"TITLE"]];
        [coursesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            NSArray *tempObjects = [objects valueForKey:@"TITLE"];
            self.coursesFromParse = [tempObjects valueForKeyPath:@"@distinctUnionOfObjects.self"];
            self.autocompleteUniversities = self.coursesFromParse;
            //NSLog(@"autocomplete 1: %@",self.coursesFromParse);
            [autocompleteUniversitiesTableView reloadData];
        }];

        
        self.haveQueriedParseForCoursesYet = YES;
    } else {
        //NSLog(@"autocomplete 2: %@",self.coursesFromParse);

    }
}

- (IBAction)searchButtonPressed:(id)sender {
    
    SearchResultsTableViewController *searchResultsTableViewController = [[SearchResultsTableViewController alloc] initWithNibName:@"SearchResultsTableViewController" bundle:nil];
    
    searchResultsTableViewController.universitySearchedString = self.universityTextField.text;
    searchResultsTableViewController.courseSearchedString = self.courseTextField.text;
    searchResultsTableViewController.locationSearchedString = self.locationTextField.text;
    
    [self.navigationController pushViewController:searchResultsTableViewController animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.anyFound == NO) {
        
    } else {
    
    if ([self.whichTextFieldActive intValue] == 1) {
        self.universityTextField.text = cell.textLabel.text;
        [self.universityTextField resignFirstResponder];
        PFQuery *queryForSelectedLocation = [PFQuery queryWithClassName:@"Institution1213"];
        [queryForSelectedLocation whereKey:@"Institution" equalTo:cell.textLabel.text];
        [queryForSelectedLocation selectKeys:[NSArray arrayWithObject:@"RegionOfInstitution"]];
        PFObject *temp = [queryForSelectedLocation getFirstObject];
        //NSLog(@"temp: %@",temp);
        NSString *tempKey = [temp valueForKey:@"RegionOfInstitution"];
        if (tempKey.length != 0) {
            self.locationTextField.text = [locationDict valueForKey:tempKey];
            [self.searchButton setEnabled:YES];
            self.pleaseSelectLabel.hidden = YES;
        }
    }
    else if ([self.whichTextFieldActive intValue] == 2) {
        self.courseTextField.text = cell.textLabel.text;
        [self.courseTextField resignFirstResponder];
    } else if ([self.whichTextFieldActive intValue] == 3) {
        self.locationTextField.text = cell.textLabel.text;
        [self.locationTextField resignFirstResponder];
    }
        autocompleteUniversitiesTableView.hidden = YES;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.universityTextField) {
        [textField resignFirstResponder];
        autocompleteUniversitiesTableView.hidden = YES;
    }
    if (textField == self.courseTextField) {
        [textField resignFirstResponder];
        autocompleteUniversitiesTableView.hidden = YES;
    }
    if (textField == self.locationTextField) {
        [textField resignFirstResponder];
        autocompleteUniversitiesTableView.hidden = YES;
    }
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
