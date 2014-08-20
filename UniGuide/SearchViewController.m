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

@synthesize universityTextField,universitiesFromParse,autocompleteUniversities,autocompleteUniversitiesTableView,courseTextField,scrollView,whichTextFieldActive,coursesFromParse,locationTextField,searchButton,locationsArray,pleaseSelectLabel,anyFound,locationDict,universityUKPRNFromParse,haveQueriedParseForCoursesYet,haveFoundAUniversity,locationButton;

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
    self.pleaseSelectLabel.text = @"Select university from list";
    self.pleaseSelectLabel.hidden = YES;
    self.haveFoundAUniversity = NO;
    [pleaseSelectLabel setFont:[UIFont systemFontOfSize:12]];
    
    CALayer *btnLayer = [searchButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    self.haveQueriedParseForCoursesYet = NO;
    
    //Query for universities and locations
    
//    NSURL *scriptUrl = [NSURL URLWithString:@"http://google.com"];
//    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    
//    if (data) {
//        PFQuery *universityQuery = [PFQuery queryWithClassName:@"Institution1213"];
//        [universityQuery setLimit:161];
//        [universityQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
//            self.universitiesFromParse = [objects valueForKey:@"Institution"];
//            self.universityUKPRNFromParse = [objects valueForKey:@"UKPRN"];
//            //NSLog(@"ukprns: %@ count: %d",self.universityUKPRNFromParse,self.universityUKPRNFromParse.count);
//        }];
//    } else {
//        NSLog(@"no internet");
//        UIAlertView *noInternetAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You appear to have no internet connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [noInternetAlert show];
//    }
    
    self.universitiesFromParse = [[NSMutableArray alloc] initWithObjects:@"Anglia Ruskin University",@"Aston University",@"Bath Spa University",@"The University of Bath",@"University of Bedfordshire",@"Birkbeck College",@"Birmingham City University",@"The University of Birmingham",@"University College Birmingham",@"Bishop Grosseteste University",@"The University of Bolton",@"The Arts University Bournemouth",@"Bournemouth University",@"The University of Bradford",@"The University of Brighton",@"The University of Bristol",@"Brunel University",@"Buckinghamshire New University",@"The University of Buckingham",@"The University of Cambridge",@"The Institute of Cancer Research",@"Canterbury Christ Church University",@"The University of Central Lancashire",@"Central School of Speech and Drama",@"University of Chester",@"The University of Chichester",@"The City University",@"Conservatoire for Dance and Drama",@"Courtauld Institute of Art",@"Coventry University",@"Cranfield University",@"University for the Creative Arts",@"University of Cumbria",@"De Montfort University",@"University of Derby",@"University of Durham",@"The University of East Anglia",@"The University of East London",@"Edge Hill University",@"The University of Essex",@"The University of Exeter",@"Falmouth University",@"University of Gloucestershire",@"Goldsmiths College",@"The University of Greenwich",@"Guildhall School of Music and Drama",@"Harper Adams University",@"University of Hertfordshire",@"Heythrop College",@"The University of Huddersfield",@"The University of Hull",@"Imperial College of Science, Technology and Medicine",@"Institute of Education",@"The University of Keele",@"The University of Kent",@"King's College London",@"Kingston University",@"The University of Lancaster",@"Leeds College of Art",@"Leeds Metropolitan University",@"The University of Leeds",@"Leeds Trinity University",@"The University of Leicester",@"The University of Lincoln",@"Liverpool Hope University",@"Liverpool John Moores University",@"The Liverpool Institute for Performing Arts",@"The University of Liverpool",@"University of the Arts, London",@"London Business School",@"University of London (Institutes and activities)",@"London Metropolitan University",@"London South Bank University",@"London School of Economics and Political Science",@"London School of Hygiene and Tropical Medicine",@"Loughborough University",@"The Manchester Metropolitan University",@"The University of Manchester",@"Middlesex University",@"The University of Newcastle-upon-Tyne",@"Newman University",@"The University of Northampton",@"The University of Northumbria at Newcastle",@"Norwich University of the Arts",@"The University of Nottingham",@"The Nottingham Trent University",@"The Open University",@"Oxford Brookes University",@"The University of Oxford",@"The University of Plymouth",@"The University of Portsmouth",@"Queen Mary University of London",@"Ravensbourne",@"The University of Reading",@"Roehampton University",@"Rose Bruford College",@"Royal Academy of Music",@"Royal Agricultural University",@"Royal College of Art",@"Royal College of Music",@"Royal Holloway and Bedford New College",@"Royal Northern College of Music",@"The Royal Veterinary College",@"St George's Hospital Medical School",@"St Mary's University College, Twickenham",@"The University of Salford",@"The School of Oriental and African Studies",@"Sheffield Hallam University",@"The University of Sheffield",@"Southampton Solent University",@"The University of Southampton",@"Staffordshire University",@"University of St Mark and St John",@"University Campus Suffolk",@"The University of Sunderland",@"The University of Surrey",@"The University of Sussex",@"Teesside University",@"Trinity Laban Conservatoire of Music and Dance",@"University College London",@"The University of Warwick",@"University of the West of England, Bristol",@"The University of West London",@"The University of Westminster",@"The University of Winchester",@"The University of Wolverhampton",@"The University of Worcester",@"Writtle College",@"York St John University",@"The University of York",@"Aberystwyth University",@"Bangor University",@"Cardiff University",@"Cardiff Metropolitan University",@"University of Glamorgan",@"Glyndŵr University",@"The University of Wales, Newport",@"Swansea University",@"University of Wales Trinity Saint David",@"The University of Aberdeen",@"University of Abertay Dundee",@"The University of Dundee",@"Edinburgh Napier University",@"The University of Edinburgh",@"Glasgow Caledonian University",@"Glasgow School of Art",@"The University of Glasgow",@"Heriot-Watt University",@"Queen Margaret University, Edinburgh",@"The Robert Gordon University",@"Royal Conservatoire of Scotland",@"The University of St Andrews",@"SRUC",@"The University of Stirling",@"The University of Strathclyde",@"University of the Highlands and Islands",@"The University of the West of Scotland",@"The Queen's University of Belfast",@"St Mary's University College",@"Stranmillis University College",@"University of Ulster", nil];
    self.universityUKPRNFromParse = [[NSMutableArray alloc] initWithObjects:@"100123",@"123123", nil];
    
    
    self.locationDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"East Of England", @"EAST", @"West Midlands", @"WMID",@"South West",@"SWES",@"London",@"LOND",@"East Midlands",@"EMID",@"North West",@"NWES",@"Yorkshire And The Humber",@"YORH",@"South East",@"SEAS", @"North East",@"NEAS",@"Wales",@"WALE",@"Scotland",@"SCOT",@"Northern Ireland",@"NIRE",nil];
    
    self.locationsArray = [self.locationDict allValues];
    
    self.autocompleteUniversities = [[NSMutableArray alloc] init];
    
    self.autocompleteUniversitiesTableView = [[UITableView alloc] initWithFrame:
                                              CGRectMake(0, 40, 320, 200) style:UITableViewStylePlain];
    self.autocompleteUniversitiesTableView.delegate = self;
    self.autocompleteUniversitiesTableView.dataSource = self;
    self.autocompleteUniversitiesTableView.scrollEnabled = YES;
    self.autocompleteUniversitiesTableView.hidden = YES;
    self.autocompleteUniversitiesTableView.rowHeight = 35;
    self.autocompleteUniversitiesTableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    [self.view addSubview:autocompleteUniversitiesTableView];
    
    self.locationButton.titleLabel.textColor = [UIColor lightGrayColor];
    self.locationButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    self.locationButton.backgroundColor = [UIColor whiteColor];
    
    CALayer *btnLayer2 = [self.locationButton layer];
    [btnLayer2 setMasksToBounds:YES];
    [btnLayer2 setCornerRadius:5.0f];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.searchButton setEnabled:NO];
    
    if (textField == self.universityTextField) {
        [self.scrollView setContentOffset:CGPointMake(0.0,12) animated:YES];
        self.whichTextFieldActive = [NSNumber numberWithInt:1];
        self.pleaseSelectLabel.hidden = NO;

    }
    if (textField == self.courseTextField) {
        [self.scrollView setContentOffset:CGPointMake(0.0,80) animated:YES];
        self.whichTextFieldActive = [NSNumber numberWithInt:2];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.universityTextField resignFirstResponder];
    [self.courseTextField resignFirstResponder];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.universityTextField) {
        [self.scrollView setContentOffset:CGPointMake(0.0,-6) animated:YES];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF = %@", self.universityTextField.text];
        NSArray *results = [self.universitiesFromParse filteredArrayUsingPredicate:predicate];
        NSLog(@"results: %@",results);
        if (results.count != 0) {
            PFQuery *queryForSelectedLocation = [PFQuery queryWithClassName:@"Institution1213"];
            [queryForSelectedLocation whereKey:@"Institution" equalTo:self.universityTextField.text];
            [queryForSelectedLocation selectKeys:[NSArray arrayWithObject:@"RegionOfInstitution"]];
            
            NSURL *scriptUrl = [NSURL URLWithString:@"http://google.com"];
            NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
            if (data) {
                NSLog(@"device connected");
                
                PFObject *temp = [queryForSelectedLocation getFirstObject];
                //NSLog(@"temp: %@",temp);
                NSString *tempKey = [temp valueForKey:@"RegionOfInstitution"];
                if (tempKey.length != 0) {
                    self.locationButton.titleLabel.text = [locationDict valueForKey:tempKey];
                     [self.searchButton setEnabled:YES];
                      self.pleaseSelectLabel.hidden = YES;
               //     self.locationButton.enabled = NO;
                }
            }
            
            self.haveFoundAUniversity = YES;
        }
        if (self.universityTextField.text.length != 0) {
            self.locationButton.enabled = NO;
            self.locationButton.backgroundColor = [UIColor lightGrayColor];
        } else {
            self.locationButton.enabled = YES;
            self.locationButton.backgroundColor = [UIColor whiteColor];
            self.haveFoundAUniversity = NO;
        }
        if (self.universityTextField.text.length == 0) {
            self.pleaseSelectLabel.hidden = YES;
        }
    }
    if (textField == self.courseTextField) {
        [self.scrollView setContentOffset:CGPointMake(0.0, -6) animated:YES];
        if (self.courseTextField.text.length != 0 || self.haveFoundAUniversity == YES) {
            self.searchButton.enabled = YES;
        }
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.autocompleteUniversities.count;
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
        self.autocompleteUniversitiesTableView.hidden = YES;
    } else {
        [self filterUniversitiesForSearchText:substring];
        self.locationButton.enabled = YES;
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
        NSURL *scriptUrl = [NSURL URLWithString:@"http://google.com"];
        NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
        if (data) {
            self.autocompleteUniversities = [[NSMutableArray alloc] initWithObjects:@"None", nil];
        } else {
            self.autocompleteUniversities = [[NSMutableArray alloc] initWithObjects:@"No internet", nil];
        }
        self.anyFound = NO;
    } else {
        self.anyFound = YES;
    }
    
    [self.autocompleteUniversitiesTableView reloadData];
}

- (void)parseQueryForCourses:(NSString *)searchText
{
    if (self.haveQueriedParseForCoursesYet == NO) {
        
        NSURL *scriptUrl = [NSURL URLWithString:@"http://google.com"];
        NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
        
        if (data) {
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
                [self.autocompleteUniversitiesTableView reloadData];
            }];
        }
        else {
            NSLog(@"no internet");
        }
        self.haveQueriedParseForCoursesYet = YES;
    } else {
        //NSLog(@"autocomplete 2: %@",self.coursesFromParse);
        
    }
}

- (IBAction)searchButtonPressed:(id)sender {
    
    NSURL *scriptUrl = [NSURL URLWithString:@"http://google.com"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    
    if (data) {
        SearchResultsTableViewController *searchResultsTableViewController = [[SearchResultsTableViewController alloc] initWithNibName:@"SearchResultsTableViewController" bundle:nil];
        
        searchResultsTableViewController.universitySearchedString = self.universityTextField.text;
        searchResultsTableViewController.courseSearchedString = self.courseTextField.text;
        if ([self.locationButton.titleLabel.text isEqualToString:@"Location...                                                   "]) {
            searchResultsTableViewController.locationSearchedString = @"";
        } else {
        searchResultsTableViewController.locationSearchedString = self.locationButton.titleLabel.text;
        }
        
        [self.navigationController pushViewController:searchResultsTableViewController animated:YES];
    } else {
        UIAlertView *noInternetAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You appear to have no internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [noInternetAlert show];
    }
    
    
    
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
            
            NSURL *scriptUrl = [NSURL URLWithString:@"http://google.com"];
            NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
            if (data) {
                NSLog(@"device connected");
                
                PFObject *temp = [queryForSelectedLocation getFirstObject];
                //NSLog(@"temp: %@",temp);
                NSString *tempKey = [temp valueForKey:@"RegionOfInstitution"];
                if (tempKey.length != 0) {
                    self.locationButton.titleLabel.text = [locationDict valueForKey:tempKey];
                    // [self.searchButton setEnabled:YES];
                    //  self.pleaseSelectLabel.hidden = YES;
                    self.locationButton.enabled = NO;
                    self.locationButton.backgroundColor = [UIColor lightGrayColor];
                }
                //self.searchButton.enabled = YES;
                //self.pleaseSelectLabel.hidden = YES;
            } else {
                NSLog(@"device not connected");
            }
            
        }
        else if ([self.whichTextFieldActive intValue] == 2) {
            self.courseTextField.text = cell.textLabel.text;
            [self.courseTextField resignFirstResponder];
        } else if ([self.whichTextFieldActive intValue] == 3) {
            self.locationButton.titleLabel.text = cell.textLabel.text;
            if (self.courseTextField.text.length != 0) {
                // self.pleaseSelectLabel.hidden = YES;
                //self.searchButton.enabled = YES;
            }
        }
        self.autocompleteUniversitiesTableView.hidden = YES;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.universityTextField) {
        [textField resignFirstResponder];
        self.autocompleteUniversitiesTableView.hidden = YES;
    }
    if (textField == self.courseTextField) {
        [textField resignFirstResponder];
        self.autocompleteUniversitiesTableView.hidden = YES;
    }
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)locationButtonPressed:(id)sender {
    
    LocationSelectTableViewController *locationSelectTableViewController = [[LocationSelectTableViewController alloc] init];
    
    locationSelectTableViewController.previousViewController = self;
    
    UINavigationController *locationSelectNavigationController = [[UINavigationController alloc]initWithRootViewController:locationSelectTableViewController];
    
    locationSelectNavigationController.navigationBar.tintColor = [UIColor whiteColor];
    locationSelectNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    locationSelectNavigationController.navigationBar.translucent = NO;
    
    [self presentViewController:locationSelectNavigationController animated:YES completion:nil];
    
}
@end
