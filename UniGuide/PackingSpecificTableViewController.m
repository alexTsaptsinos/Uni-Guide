//
//  PackingSpecificTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import "PackingSpecificTableViewController.h"

@interface PackingSpecificTableViewController ()

@end

@implementation PackingSpecificTableViewController

@synthesize essentialItems,desirableItems,categoryString,checkboxImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationItem.title = self.categoryString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return self.essentialItems.count;
    } else {
        return self.desirableItems.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    if (indexPath.section == 0) {
        cell.textLabel.text = [self.essentialItems objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [self.desirableItems objectAtIndex:indexPath.row];
    }
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    checkboxImageView = [[UIImageView alloc] init];
//    checkboxImageView.frame = CGRectMake(280, 13, 20, 20);
//    checkboxImageView.image = [UIImage imageNamed:@"unchecked_checkbox.png"];
//    [cell addSubview:checkboxImageView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f]];
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,self.view.bounds.size.width,22)];
    
    tempLabel.textColor = [UIColor whiteColor];
    if (section == 0) {
        tempLabel.text=@"Essentials:";
    } else {
        tempLabel.text = @"Desirables:";
    }
    
    [headerView addSubview:tempLabel];
    return headerView;
    
}

//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (checkboxImageView.image == [UIImage imageNamed:@"unchecked_checkbox.png"]) {
//        checkboxImageView.image = [UIImage imageNamed:@"checked_checkbox.png"];
//    } else {
//        checkboxImageView.image = [UIImage imageNamed:@"checked_checkbox.png"];
//    }
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}



@end
