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
    
    self.pleaseSelectLabel.textColor = [UIColor grayColor];
    self.pleaseSelectLabel.text = @"Select university from list";
    self.pleaseSelectLabel.hidden = YES;
    self.haveFoundAUniversity = NO;
    [pleaseSelectLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [searchButton addTarget:self
                              action:@selector(searchButtonClicked:)
                    forControlEvents:UIControlEventTouchUpInside];
    [searchButton setTitle:@"Search" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    self.searchButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    
    CALayer *btnLayer = [searchButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    
    if (screenBound.size.height > 500) {
        searchButton.frame = CGRectMake(93.0, 410.0, 134.0, 37.0);
    } else {
        searchButton.frame = CGRectMake(93.0, 330.0, 134.0, 37.0);
    }
    
    [self.view addSubview:searchButton];
    [searchButton setEnabled:NO];

    
    self.haveQueriedParseForCoursesYet = NO;
    
    self.universitiesFromParse = [[NSMutableArray alloc] initWithObjects:@"Anglia Ruskin University",@"Aston University",@"Bath Spa University",@"The University of Bath",@"University of Bedfordshire",@"Birkbeck College",@"Birmingham City University",@"The University of Birmingham",@"University College Birmingham",@"Bishop Grosseteste University",@"The University of Bolton",@"The Arts University Bournemouth",@"Bournemouth University",@"The University of Bradford",@"The University of Brighton",@"The University of Bristol",@"Brunel University",@"Buckinghamshire New University",@"The University of Buckingham",@"The University of Cambridge",@"The Institute of Cancer Research",@"Canterbury Christ Church University",@"The University of Central Lancashire",@"Central School of Speech and Drama",@"University of Chester",@"The University of Chichester",@"The City University",@"Conservatoire for Dance and Drama",@"Courtauld Institute of Art",@"Coventry University",@"Cranfield University",@"University for the Creative Arts",@"University of Cumbria",@"De Montfort University",@"University of Derby",@"University of Durham",@"The University of East Anglia",@"The University of East London",@"Edge Hill University",@"The University of Essex",@"The University of Exeter",@"Falmouth University",@"University of Gloucestershire",@"Goldsmiths College",@"The University of Greenwich",@"Guildhall School of Music and Drama",@"Harper Adams University",@"University of Hertfordshire",@"Heythrop College",@"The University of Huddersfield",@"The University of Hull",@"Imperial College of Science, Technology and Medicine",@"Institute of Education",@"The University of Keele",@"The University of Kent",@"King's College London",@"Kingston University",@"The University of Lancaster",@"Leeds College of Art",@"Leeds Metropolitan University",@"The University of Leeds",@"Leeds Trinity University",@"The University of Leicester",@"The University of Lincoln",@"Liverpool Hope University",@"Liverpool John Moores University",@"The Liverpool Institute for Performing Arts",@"The University of Liverpool",@"University of the Arts, London",@"London Business School",@"University of London (Institutes and activities)",@"London Metropolitan University",@"London South Bank University",@"London School of Economics and Political Science",@"London School of Hygiene and Tropical Medicine",@"Loughborough University",@"The Manchester Metropolitan University",@"The University of Manchester",@"Middlesex University",@"The University of Newcastle-upon-Tyne",@"Newman University",@"The University of Northampton",@"The University of Northumbria at Newcastle",@"Norwich University of the Arts",@"The University of Nottingham",@"The Nottingham Trent University",@"The Open University",@"Oxford Brookes University",@"The University of Oxford",@"The University of Plymouth",@"The University of Portsmouth",@"Queen Mary University of London",@"Ravensbourne",@"The University of Reading",@"Roehampton University",@"Rose Bruford College",@"Royal Academy of Music",@"Royal Agricultural University",@"Royal College of Art",@"Royal College of Music",@"Royal Holloway and Bedford New College",@"Royal Northern College of Music",@"The Royal Veterinary College",@"St George's Hospital Medical School",@"St Mary's University College, Twickenham",@"The University of Salford",@"The School of Oriental and African Studies",@"Sheffield Hallam University",@"The University of Sheffield",@"Southampton Solent University",@"The University of Southampton",@"Staffordshire University",@"University of St Mark and St John",@"University Campus Suffolk",@"The University of Sunderland",@"The University of Surrey",@"The University of Sussex",@"Teesside University",@"Trinity Laban Conservatoire of Music and Dance",@"University College London",@"The University of Warwick",@"University of the West of England, Bristol",@"The University of West London",@"The University of Westminster",@"The University of Winchester",@"The University of Wolverhampton",@"The University of Worcester",@"Writtle College",@"York St John University",@"The University of York",@"Aberystwyth University",@"Bangor University",@"Cardiff University",@"Cardiff Metropolitan University",@"Glyndŵr University",@"The University of Wales, Newport",@"Swansea University",@"University of Wales Trinity Saint David",@"The University of Aberdeen",@"University of Abertay Dundee",@"The University of Dundee",@"Edinburgh Napier University",@"The University of Edinburgh",@"Glasgow Caledonian University",@"Glasgow School of Art",@"The University of Glasgow",@"Heriot-Watt University",@"Queen Margaret University, Edinburgh",@"The Robert Gordon University",@"Royal Conservatoire of Scotland",@"The University of St Andrews",@"SRUC",@"The University of Stirling",@"The University of Strathclyde",@"University of the Highlands and Islands",@"The University of the West of Scotland",@"The Queen's University of Belfast",@"St Mary's University College",@"Stranmillis University College",@"University of Ulster", nil];
    
    
    self.universityUKPRNFromParse = [[NSMutableArray alloc] initWithObjects:@"10000291",@"10007759",@"10000571",@"10007850",@"10007152",@"10007760",@"10007140",@"10006840",@"10000712",@"10007811", @"10006841",@"10000385",@"10000824",@"10007785",@"10000886",@"10007786",@"10000961",@"10000975",@"10007787",@"10007788",@"10003324",@"10001143",@"10007141",@"10007816",@"10007848",@"10007137",@"10001478",@"10001653",@"10007761",@"10001726",@"10007822",@"10006427",@"10007842",@"10001883",@"10007851",@"10007143",@"10007789",@"10007144",@"10007823",@"10007791",@"10007792",@"10008640",@"10007145",@"10002718",@"10007146",@"10007825",@"10040812",@"10007147",@"10007765",@"10007148",@"10007149",@"10003270",@"10007766",@"10007767",@"10007150",@"10003645",@"10003678",@"10007768",@"10003854",@"10003861",@"10007795",@"10003863",@"10007796",@"10007151",@"10003956",@"10003957",@"10003945",@"10006842",@"10007162",@"10007769",@"10007797",@"10004048",@"10004078",@"10004063",@"10007771",@"10004113",@"10004180",@"10007798",@"10004351",@"10007799",@"10007832",@"10007138",@"10001282",@"10004775",@"10007154",@"10004797",@"10007773",@"10004930",@"10007774",@"10007801",@"10007155",@"10007775",@"10005389",@"10007802",@"10007776",@"10005523",@"10007835",@"10005545",@"10007777",@"10007778",@"10005553",@"10007837",@"10007779",@"10007782",@"10007843",@"10007156",@"10007780",@"10005790",@"10007157",@"10006022",@"10007158",@"10006299",@"10037449",@"10014001",@"10007159",@"10007160",@"10007806",@"10007161",@"10008017",@"10007784",@"10007163",@"10007164",@"10006566",@"10007165",@"10003614",@"10007166",@"10007139",@"10007657",@"10007713",@"10007167",@"10007856",@"10007857",@"10007814",@"10007854",@"10007833",@"10007853",@"10007855",@"10007858",@"10007783",@"10007849",@"10007852",@"10007772",@"10007790",@"10007762",@"10002681",@"10007794",@"10007764",@"10005337",@"10005500",@"10005561",@"10007803",@"10005700",@"10007804",@"10007805",@"10007114",@"10007800",@"10005343",@"10008026",@"10008010",@"10007807", nil];
    
    
    self.locationDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"East Of England", @"EAST", @"West Midlands", @"WMID",@"South West",@"SWES",@"London",@"LOND",@"East Midlands",@"EMID",@"North West",@"NWES",@"Yorkshire And The Humber",@"YORH",@"South East",@"SEAS", @"North East",@"NEAS",@"Wales",@"WALE",@"Scotland",@"SCOT",@"Northern Ireland",@"NIRE",nil];
    
    self.locationsArray = [self.locationDict allValues];
    
    self.autocompleteUniversities = [[NSMutableArray alloc] init];
    
    
    self.autocompleteUniversitiesTableView = [[UITableView alloc] initWithFrame:
                                              CGRectMake(0, 40, 320, screenBound.size.height - 320) style:UITableViewStylePlain];
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
    self.locationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.locationButton.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);

    
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
        self.autocompleteUniversitiesTableView.hidden = YES;
        if (results.count != 0) {
            PFQuery *queryForSelectedLocation = [PFQuery queryWithClassName:@"Institution1213"];
            [queryForSelectedLocation whereKey:@"Institution" equalTo:self.universityTextField.text];
            [queryForSelectedLocation selectKeys:[NSArray arrayWithObject:@"RegionOfInstitution"]];

                NSLog(@"device connected");
                
                [queryForSelectedLocation findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
                    if (!error) {
                        NSArray *tempArray = [objects objectAtIndex:0];
                        NSString *tempKey = [tempArray valueForKey:@"RegionOfInstitution"];
                        NSLog(@"tempKey: %@",tempKey);
                        if (tempKey.length != 0) {
                            NSString *location = [locationDict valueForKey:tempKey];
                            [self.searchButton setEnabled:YES];
                            [self.locationButton setTitle:location forState:UIControlStateDisabled];
                            [self.locationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
                            self.pleaseSelectLabel.hidden = YES;
                        }
                    }
                    else {
                        NSString *noLocation = @"Locked";
                        [self.locationButton setTitle:noLocation forState:UIControlStateDisabled];
                        self.locationButton.titleLabel.textAlignment = NSTextAlignmentLeft;
                    }
                    
                }];
            
            self.haveFoundAUniversity = YES;
        }
        else {
            NSString *noLocation = @"Select a university";
            [self.locationButton setTitle:noLocation forState:UIControlStateDisabled];
        }
        if (self.universityTextField.text.length != 0) {
            self.locationButton.enabled = NO;
            self.locationButton.backgroundColor = [UIColor lightGrayColor];
        } else {
            self.locationButton.enabled = YES;
            self.locationButton.backgroundColor = [UIColor whiteColor];
            self.haveFoundAUniversity = NO;
            if (self.courseTextField.text.length) {
                self.searchButton.enabled = YES;
            }
        }
        if (self.universityTextField.text.length == 0) {
            self.pleaseSelectLabel.hidden = YES;
        }
    }
    else if (textField == self.courseTextField) {
        [self.scrollView setContentOffset:CGPointMake(0.0, -6) animated:YES];
        if ((self.courseTextField.text.length != 0 && self.universityTextField.text.length == 0) || self.haveFoundAUniversity == YES) {
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
        cell.textLabel.textColor = [UIColor lightGrayColor];
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
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
        //self.locationButton.enabled = YES;
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
        
        if (self.courseTextField.text.length < 2) {
            
            self.autocompleteUniversities = [[NSMutableArray alloc] initWithObjects:@"Enter More For Suggestions", nil];
            self.haveQueriedParseForCoursesYet = NO;
            
        } else {
            
            [self parseQueryForCourses:searchText];
            self.autocompleteUniversities = [coursesFromParse filteredArrayUsingPredicate:universitiesPredicate];
        }
        
        
    } else if ([self.whichTextFieldActive intValue] == 3) {
        self.autocompleteUniversities = [locationsArray filteredArrayUsingPredicate:universitiesPredicate];
    }
    
    
    if (self.autocompleteUniversities.count == 0) {
        self.autocompleteUniversities = [[NSMutableArray alloc] initWithObjects:@"No Results", nil];
        self.anyFound = NO;
    } else {
        self.anyFound = YES;
    }
    
    [self.autocompleteUniversitiesTableView reloadData];
}

- (void)parseQueryForCourses:(NSString *)searchText
{
    if (self.haveQueriedParseForCoursesYet == NO) {
        
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(115, 7, 20, 20)];
        [self.autocompleteUniversitiesTableView addSubview:activity];
        [activity startAnimating];
        activity.color = [UIColor grayColor];
        activity.hidesWhenStopped = YES;
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
                if (!error) {
                    NSArray *tempObjects = [objects valueForKey:@"TITLE"];
                    self.coursesFromParse = [tempObjects valueForKeyPath:@"@distinctUnionOfObjects.self"];
                    self.autocompleteUniversities = self.coursesFromParse;
                    //NSLog(@"autocomplete 1: %@",self.coursesFromParse);
                    [self.autocompleteUniversitiesTableView reloadData];
                    [activity stopAnimating];
                }
                else {
                    
                }
            }];

        self.haveQueriedParseForCoursesYet = YES;
    } else {
        
    }
}

- (void)searchButtonClicked:(UIButton*)button
{

        SearchResultsTableViewController *searchResultsTableViewController = [[SearchResultsTableViewController alloc] initWithNibName:@"SearchResultsTableViewController" bundle:nil];
        
        searchResultsTableViewController.universitySearchedString = self.universityTextField.text;
        searchResultsTableViewController.courseSearchedString = self.courseTextField.text;
        if ([self.locationButton.titleLabel.text isEqualToString:@"Location..."]) {
            searchResultsTableViewController.locationSearchedString = @"";
        } else {
            searchResultsTableViewController.locationSearchedString = self.locationButton.titleLabel.text;
        }
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
            self.autocompleteUniversitiesTableView.hidden = YES;
            [self.universityTextField resignFirstResponder];
            PFQuery *queryForSelectedLocation = [PFQuery queryWithClassName:@"Institution1213"];
            [queryForSelectedLocation whereKey:@"Institution" equalTo:cell.textLabel.text];
            [queryForSelectedLocation selectKeys:[NSArray arrayWithObject:@"RegionOfInstitution"]];
            [self.searchButton setEnabled:YES];
            self.pleaseSelectLabel.hidden = YES;

            
            NSURL *scriptUrl = [NSURL URLWithString:@"http://google.com"];
            NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
            if (data) {
                NSLog(@"device connected");
                
                [queryForSelectedLocation findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
                    NSArray *tempArray = [objects objectAtIndex:0];
                    NSString *tempKey = [tempArray valueForKey:@"RegionOfInstitution"];
                    NSLog(@"tempKey: %@",tempKey);
                    if (tempKey.length != 0) {
                        NSString *location = [locationDict valueForKey:tempKey];
                        [self.searchButton setEnabled:YES];
                        [self.locationButton setTitle:location forState:UIControlStateDisabled];
                        [self.locationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
                        self.pleaseSelectLabel.hidden = YES;
                    }
                }];

            } else {
                NSLog(@"device not connected");
            }
            
        }
        else if ([self.whichTextFieldActive intValue] == 2) {
            self.courseTextField.text = cell.textLabel.text;
            [self.courseTextField resignFirstResponder];
            self.autocompleteUniversitiesTableView.hidden = YES;
        }
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
