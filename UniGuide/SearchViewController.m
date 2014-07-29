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

@synthesize universityTextField,/*searchButtonSearchViewController*/universitiesFromParse,autocompleteUniversities,autocompleteUniversitiesTableView;

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
    
    //[searchButtonSearchViewController setEnabled:NO];
    
    PFQuery *universityQuery = [PFQuery queryWithClassName:@"Universities"];
    [universityQuery setLimit:415];
     [universityQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error) {
        self.universitiesFromParse = [objects valueForKey:@"Name"];
     }];
    self.autocompleteUniversities = [[NSMutableArray alloc] init];
    
    autocompleteUniversitiesTableView = [[UITableView alloc] initWithFrame:
                             CGRectMake(0, 100, 320, 200) style:UITableViewStylePlain];
    autocompleteUniversitiesTableView.delegate = self;
    autocompleteUniversitiesTableView.dataSource = self;
    autocompleteUniversitiesTableView.scrollEnabled = YES;
    autocompleteUniversitiesTableView.hidden = YES;
    autocompleteUniversitiesTableView.rowHeight = 35;
    [self.view addSubview:autocompleteUniversitiesTableView];
    
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
    
    cell.textLabel.text = [autocompleteUniversities objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    autocompleteUniversitiesTableView.hidden = NO;
    
    NSString *substring = [NSString stringWithString:textField.text];
    //NSLog(@"%@", substring);
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"%@", substring);
    if (substring.length == 0) {
        autocompleteUniversitiesTableView.hidden = YES;
    } else {
    [self filterUniversitiesForSearchText:substring];
    }
    return YES;
}

- (void)filterUniversitiesForSearchText:(NSString*)searchText
{
   // NSLog(@"from parse: %@", self.universitiesFromParse);
    
    NSPredicate *universitiesPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    self.autocompleteUniversities = [universitiesFromParse filteredArrayUsingPredicate:universitiesPredicate];
    
    if (self.autocompleteUniversities.count == 0) {
        self.autocompleteUniversities = [[NSMutableArray alloc] initWithObjects:@"None", nil];
    }
    
    [autocompleteUniversitiesTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell = [tableView cellForRowAtIndexPath:indexPath];
    
    self.universityTextField.text = cell.textLabel.text;
    [self.universityTextField resignFirstResponder];
    autocompleteUniversitiesTableView.hidden = YES;
}

//- (void)searchUniversitiesAutocompleteEntriesWithSubstring:(NSString *)substring
//{
//    [autocompleteUniversities removeAllObjects];
////    for (NSString *curString in universitiesFromParse) {
////        NSLog(@"cureString: %@",curString);
////        NSRange substringRange = [curString rangeOfString:substring];
////        if (substringRange.location == 0) {
////            [autocompleteUniversities addObject:curString];
////        }
////    }
//    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", substring];
//    
//    self.autocompleteUniversities = [universitiesFromParse filteredArrayUsingPredicate:resultPredicate];    
//    
//    NSLog(@"blah: %@", autocompleteUniversities);
//    [autocompleteUniversitiesTableView reloadData];
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.universityTextField) {
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

//Make sure keyboard goes away when hit return for university,course,location search fields

//- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    [searchBar resignFirstResponder];
//}
//
//- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    for(UIView *subView in [searchBar subviews]) {
//        if([subView conformsToProtocol:@protocol(UITextInputTraits)]) {
//            [(UITextField *)subView setReturnKeyType: UIReturnKeyDone];
//        } else {
//            for(UIView *subSubView in [subView subviews]) {
//                if([subSubView conformsToProtocol:@protocol(UITextInputTraits)]) {
//                    [(UITextField *)subSubView setReturnKeyType: UIReturnKeyDone];
//                }
//            }      
//        }
//    }
//}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [[event allTouches] anyObject];
//    if ([courseSearchField isFirstResponder] && [touch view] != courseSearchField) {
//        [courseSearchField resignFirstResponder];
//    }
//    if ([universitySearchField isFirstResponder] && [touch view] != universitySearchField) {
//        [universitySearchField resignFirstResponder];
//    }
//    if ([locationSearchField isFirstResponder] && [touch view] != locationSearchField) {
//        [locationSearchField resignFirstResponder];
//    }
//    [super touchesBegan:touches withEvent:event];
//}

//- (BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
//{
//    return YES;
//}

//- (IBAction)editingChanged
//{
//    if ([universityTextField.text length] != 0 /*|| [universityTextFieldSearchViewController.text length] != 0 || [locationTextFieldSearchViewController.text length] != 0*/) {
//        [searchButtonSearchViewController setEnabled:YES];
//    } else {
//        [searchButtonSearchViewController setEnabled:NO];
//    }
//}

//when search button is pressed, push main view controller which contains results table view and filter view

//- (IBAction)searchButtonSearchViewControllerPressed:(id)sender {
//    
//    
//    
//    SearchResultsTableViewController *searchResultsTableViewController = [[SearchResultsTableViewController alloc] initWithNibName:@"SearchResultsTableViewController" bundle:nil];
//    
//    searchResultsTableViewController.universitySearchedString = self.universityTextField.text;
////    searchResultsTableViewController.universitySearchedString = self.universityTextFieldSearchViewController.text;
////    searchResultsTableViewController.locationSearchedString = self.locationTextFieldSearchViewController.text;
//    
//    [self.navigationController pushViewController:searchResultsTableViewController animated:YES];
//    
//}
@end
