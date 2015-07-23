//
//  PackingListTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import "PackingListTableViewController.h"

@interface PackingListTableViewController ()

@end

@implementation PackingListTableViewController

@synthesize itemsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    itemsArray = [[NSArray alloc] initWithObjects:@"Documents",@"Kitchen",@"Studying",@"Bathroom",@"Bedroom",@"Clothing",@"Electricals",@"Healthcare",@"Miscellaneous", nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationItem.title = @"Packing List";
    

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
    return self.itemsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.itemsArray objectAtIndex:indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];

    return cell;
}


// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    PackingSpecificTableViewController *packingSpecificTableViewController = [[PackingSpecificTableViewController alloc] initWithNibName:@"PackingSpecificTableViewController" bundle:nil];
    packingSpecificTableViewController.categoryString = [self.itemsArray objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        // DOCUMENTS
        packingSpecificTableViewController.essentialItems = [[NSArray alloc] initWithObjects:@"Valid passport",@"Entry visa (if applicable)",@"Passport photos",@"University acceptance letter",@"Driving license",@"National Insurance number",@"NHS Number",@"Bank account details",@"Financial support documents",@"Home doctor/dentist details",@"Relevant exam certificates",@"Chequebook",@"Insurance documents", nil];
        packingSpecificTableViewController.desirableItems = [[NSArray alloc] initWithObjects:@"Diary/calender",@"TV license", @"Map of local area", @"Stamps/Envelopes", @"What's on guide", @"Student discount cards",@"Vaccination history details", nil];
    } else if (indexPath.row == 1) {
        // KITCHEN
        packingSpecificTableViewController.essentialItems = [[NSArray alloc] initWithObjects:@"Plates", @"Bowls", @"Mugs", @"Glasses",@"Cutlery", @"Frying pan",@"Saucepan",@"Tin opener", @"Cutting knives", @"Scissors", @"Chopping board", @"Peeler", @"Wooden spoon", @"Tea towel", @"Food containers", @"Colander/sieve",@"Bottle opener", @"Washing up items",@"Bin bags", nil];
        packingSpecificTableViewController.desirableItems = [[NSArray alloc] initWithObjects:@"Cheese grater", @"Spatula", @"Recipe book", @"Shot glasses",@"Egg cup", @"Sandwich bags",@"Microwaveable bowl",@"Cling film", @"Tin foil", @"Oven gloves", @"Chopsticks", @"Kitchen tongs",@"Kettle (if not provided)",@"Toaster (if not provided)", nil];
    } else if (indexPath.row == 2) {
        // STUDYING
        packingSpecificTableViewController.essentialItems = [[NSArray alloc] initWithObjects:@"Basic stationary", @"Course books", @"Course notes", @"Translation book (if applicable)", @"Lined paper pad",@"Desk lamp (if not provided)", @"Calculator (if applicable)", nil];
        packingSpecificTableViewController.desirableItems = [[NSArray alloc] initWithObjects:@"Day planner", @"Memory stick", @"Dictionary", @"Post-it notes", @"Scissors",@"Printing paper", @"Sticky tape",@"Stapler",@"Hole punch", @"Paper clips", @"Files/Folders", @"Sticky labels", @"Book stand", @"Pin board",@"Push pins", @"Whiteboard",@"White tack", nil];
    } else if (indexPath.row == 3) {
        // BATHROOM
        packingSpecificTableViewController.essentialItems = [[NSArray alloc] initWithObjects:@"Shampoo & conditioner", @"Shower gel", @"Soap", @"Deodorant",@"Toothbrush", @"Toothpaste", @"Toilet roll (if not provided)",@"Face towel", @"Hand towel", @"Bath towel", @"Hairbrush/comb", @"Tissues", @"Razor", @"Shaving cream", nil];
        packingSpecificTableViewController.desirableItems = [[NSArray alloc] initWithObjects:@"Hair dryer", @"Hair straighteners", @"Wash bag", @"Nail clippers",@"Make up", @"Perfumer/after-shave", @"Hair gel/spray",@"Lip balm", @"Bath mat", @"Shower basket", nil];
    } else if (indexPath.row == 4) {
        // BEDROOM
        packingSpecificTableViewController.essentialItems = [[NSArray alloc] initWithObjects:@"Duvet", @"Duvet cover", @"Pillows", @"Pillow cases",@"Bedsheets", @"Clothes hangers",@"Laundry bag", nil];
        packingSpecificTableViewController.desirableItems = [[NSArray alloc] initWithObjects:@"Mattress topper", @"Blanket/Throw", @"Hot water bottle", @"Sleeping bag", nil];
    } else if (indexPath.row == 5) {
        // CLOTHING
        packingSpecificTableViewController.essentialItems = [[NSArray alloc] initWithObjects:@"T-shirts", @"Jumpers",@"Shirts" @"Trousers",@"Shorts", @"Underwear",@"Socks", @"Raincoat",@"Formal eveningwear",@"Shoes/trainers", @"Winter coat",@"Belts", nil];
        packingSpecificTableViewController.desirableItems = [[NSArray alloc] initWithObjects:@"Dressing gown", @"Slippers", @"Sports clothing", @"Swimwear", @"Flip flops",@"Hat", @"Scarf",@"Gloves",@"Ties", nil];
    } else if (indexPath.row == 6) {
        // ELECTRICALS
        packingSpecificTableViewController.essentialItems = [[NSArray alloc] initWithObjects:@"Mobile phone", @"Adaptor plug (if needed)", @"Laptop/computer",@"Chargers", @"Ethernet cable",@"Alarm clock radio", @"Multi plug extension cable", nil];
        packingSpecificTableViewController.desirableItems = [[NSArray alloc] initWithObjects:@"Bedside lamp", @"Printer", @"Music system", @"Small TV",@"Camera",@"MP3 player/iPod", @"Headphones", @"Batteries", @"Rice cooker (if allowed)", @"Mini fridge (if allowed)", nil];
    } else if (indexPath.row == 7) {
        // HEALTHCARE
        packingSpecificTableViewController.essentialItems = [[NSArray alloc] initWithObjects:@"Glasses", @"Contact lenses", @"Personal medication", @"Anti-allergy pills",@"Birth control", @"Condoms", @"Painkillers", @"Cold/flu remedies", @"Basic first aid kit", nil];
        packingSpecificTableViewController.desirableItems = [[NSArray alloc] initWithObjects:@"Multivitamins", @"Throat lozenges", nil];
    } else if (indexPath.row == 8) {
        // MISC
        packingSpecificTableViewController.essentialItems = [[NSArray alloc] initWithObjects:@"Umbrella", @"Earplugs", @"Safety pins", @"Clock",@"Photos of family/friends", nil];
        packingSpecificTableViewController.desirableItems = [[NSArray alloc] initWithObjects:@"Small sewing kit", @"Matches", @"Bicycle", @"Sports gear", @"Torch", @"Fan",@"Storage solutions",@"Large suitcase", @"Duster", @"Clothes horse", @"Posters", @"Rugs", @"Cushions", @"Beanbag", @"Door wedge", @"Pack of cards",@"Board games", @"Ball/Frisbee", @"Potted plant", @"Teddy bear", @"Books", @"Musical instrument(s)", nil];
    }

    
    // Push the view controller.
    [self.navigationController pushViewController:packingSpecificTableViewController animated:YES];
}


@end
