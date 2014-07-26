//
//  UniversitiesViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 26/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "UniversitiesViewController.h"

@interface UniversitiesViewController ()

@end

@implementation UniversitiesViewController

-(id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // the className to query on
        self.parseClassName = @"Universities";
        
        // the key of the PFObject to display in the label of the default cell style
        self.textKey = @"SortableName";
        
        //whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = NO;
        
        //whether the built-in pagination is enabled
        self.paginationEnabled = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *simpleTableIdentifier = @"UniversityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    // configure the cell
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:101];
    nameLabel.text = [object objectForKey:@"SortableName"];
    
    return cell;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
