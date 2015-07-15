//
//  UniversitiesListTableViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 21/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "UniversitiesListTableViewController.h"

@interface UniversitiesListTableViewController ()

@end

@implementation UniversitiesListTableViewController

@synthesize universities,alphabetsArray,universitiesUKPRNS,sections,hasSearchingCommenced,sortedUniversities,universitiesSortableNames;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Universities";
    self.navigationController.navigationBar.translucent = NO;
    self.sections = [[NSMutableDictionary alloc] init];
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.hasSearchingCommenced = NO;
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    
    //    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    //    self.tableView.tableHeaderView = self.searchBar;
    //
    //    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    //
    //    self.searchController.searchResultsDataSource = self;
    //    self.searchController.searchResultsDelegate = self;
    //    self.searchController.delegate = self;
    //    self.searchBar.delegate = self;
    
    self.searchResults = [NSMutableArray array];
    alphabetsArray = [[NSMutableArray alloc] init];
    [alphabetsArray addObject:@"A"];
    [alphabetsArray addObject:@"B"];
    [alphabetsArray addObject:@"C"];
    [alphabetsArray addObject:@"D"];
    [alphabetsArray addObject:@"E"];
    [alphabetsArray addObject:@"F"];
    [alphabetsArray addObject:@"G"];
    [alphabetsArray addObject:@"H"];
    [alphabetsArray addObject:@"I"];
    [alphabetsArray addObject:@"J"];
    [alphabetsArray addObject:@"K"];
    [alphabetsArray addObject:@"L"];
    [alphabetsArray addObject:@"M"];
    [alphabetsArray addObject:@"N"];
    [alphabetsArray addObject:@"O"];
    [alphabetsArray addObject:@"P"];
    [alphabetsArray addObject:@"Q"];
    [alphabetsArray addObject:@"R"];
    [alphabetsArray addObject:@"S"];
    [alphabetsArray addObject:@"T"];
    [alphabetsArray addObject:@"U"];
    [alphabetsArray addObject:@"V"];
    [alphabetsArray addObject:@"W"];
    [alphabetsArray addObject:@"X"];
    [alphabetsArray addObject:@"Y"];
    [alphabetsArray addObject:@"Z"];
    
    self.universities = [[NSMutableArray alloc] initWithObjects:@"Anglia Ruskin University",@"Aston University",@"Bath Spa University",@"The University of Bath",@"University of Bedfordshire",@"Birkbeck College",@"Birmingham City University",@"The University of Birmingham",@"University College Birmingham",@"Bishop Grosseteste University",@"The University of Bolton",@"The Arts University Bournemouth",@"Bournemouth University",@"The University of Bradford",@"The University of Brighton",@"The University of Bristol",@"Brunel University",@"Buckinghamshire New University",@"The University of Buckingham",@"The University of Cambridge",@"Canterbury Christ Church University",@"The University of Central Lancashire",@"Central School of Speech and Drama",@"University of Chester",@"The University of Chichester",@"The City University",@"Conservatoire for Dance and Drama",@"Courtauld Institute of Art",@"Coventry University",@"Cranfield University",@"University for the Creative Arts",@"University of Cumbria",@"De Montfort University",@"University of Derby",@"University of Durham",@"The University of East Anglia",@"The University of East London",@"Edge Hill University",@"The University of Essex",@"The University of Exeter",@"Falmouth University",@"University of Gloucestershire",@"Goldsmiths College",@"The University of Greenwich",@"Guildhall School of Music and Drama",@"Harper Adams University",@"University of Hertfordshire",@"Heythrop College",@"The University of Huddersfield",@"The University of Hull",@"Imperial College of Science, Technology and Medicine",@"Institute of Education",@"The University of Keele",@"The University of Kent",@"King's College London",@"Kingston University",@"The University of Lancaster",@"Leeds College of Art",@"Leeds Beckett University",@"The University of Leeds",@"Leeds Trinity University",@"The University of Leicester",@"The University of Lincoln",@"Liverpool Hope University",@"Liverpool John Moores University",@"The Liverpool Institute for Performing Arts",@"The University of Liverpool",@"University of the Arts, London",@"London Business School",@"University of London (Institutes and activities)",@"London Metropolitan University",@"London South Bank University",@"London School of Economics and Political Science",@"London School of Hygiene and Tropical Medicine",@"Loughborough University",@"The Manchester Metropolitan University",@"The University of Manchester",@"Middlesex University",@"The University of Newcastle-upon-Tyne",@"Newman University",@"The University of Northampton",@"The University of Northumbria at Newcastle",@"Norwich University of the Arts",@"The University of Nottingham",@"The Nottingham Trent University",@"The Open University",@"Oxford Brookes University",@"The University of Oxford",@"The University of Plymouth",@"The University of Portsmouth",@"Queen Mary University of London",@"Ravensbourne",@"The University of Reading",@"Roehampton University",@"Rose Bruford College",@"Royal Academy of Music",@"Royal Agricultural University",@"Royal College of Art",@"Royal College of Music",@"Royal Holloway and Bedford New College",@"Royal Northern College of Music",@"The Royal Veterinary College",@"St George's Hospital Medical School",@"St Mary's University College, Twickenham",@"The University of Salford",@"The School of Oriental and African Studies",@"Sheffield Hallam University",@"The University of Sheffield",@"Southampton Solent University",@"The University of Southampton",@"Staffordshire University",@"University of St Mark and St John",@"University Campus Suffolk",@"The University of Sunderland",@"The University of Surrey",@"The University of Sussex",@"Teesside University",@"Trinity Laban Conservatoire of Music and Dance",@"University College London",@"The University of Warwick",@"University of the West of England, Bristol",@"The University of West London",@"The University of Westminster",@"The University of Winchester",@"The University of Wolverhampton",@"The University of Worcester",@"Writtle College",@"York St John University",@"The University of York",@"Aberystwyth University",@"Bangor University",@"Cardiff University",@"Cardiff Metropolitan University",@"University of Glamorgan",@"Glyndŵr University",@"The University of Wales, Newport",@"Swansea University",@"University of Wales Trinity Saint David",@"The University of Aberdeen",@"University of Abertay Dundee",@"The University of Dundee",@"Edinburgh Napier University",@"The University of Edinburgh",@"Glasgow Caledonian University",@"Glasgow School of Art",@"The University of Glasgow",@"Heriot-Watt University",@"Queen Margaret University, Edinburgh",@"The Robert Gordon University",@"Royal Conservatoire of Scotland",@"The University of St Andrews",@"SRUC",@"The University of Stirling",@"The University of Strathclyde",@"University of the Highlands and Islands",@"The University of the West of Scotland",@"The Queen's University of Belfast",@"St Mary's University College",@"Stranmillis University College",@"University of Ulster", nil];
    
    self.universitiesSortableNames = [[NSMutableArray alloc] initWithObjects:@"Anglia Ruskin University",@"Aston University",@"Bath Spa University",@"Bath, The University of",@"Bedfordshire, University of",@"Birkbeck College",@"Birmingham City University",@"Birmingham, The University of",@"University College Birmingham",@"Bishop Grosseteste University",@"Bolton, The University of",@"Arts University Bournemouth, The",@"Bournemouth University",@"Bradford, The University of",@"Brighton, The University of",@"Bristol, The University of",@"Brunel University",@"Buckinghamshire New University",@"Buckingham, The University of",@"Cambridge, The University of",@"Canterbury Christ Church University",@"Central Lancashire, The University of",@"Central School of Speech and Drama",@"Chester, University of",@"Chichester, The University of",@"City University, The",@"Conservatoire for Dance and Drama",@"Courtauld Institute of Art",@"Coventry University",@"Cranfield University",@"University for the Creative Arts",@"Cumbria, University of",@"De Montfort University",@"Derby, University of",@"Durham, University of",@"East Anglia, The University of",@"East London, The University of",@"Edge Hill University",@"Essex, The University of",@"Exeter, The University of",@"Falmouth University",@"Gloucestershire, University of",@"Goldsmiths College",@"Greenwich, The University of",@"Guildhall School of Music and Drama",@"Harper Adams University",@"Hertfordshire, University of",@"Heythrop College",@"Huddersfield, The University of",@"Hull, The University of",@"Imperial College of Science, Technology and Medicine",@"Institute of Education",@"Keele, The University of",@"Kent, The University of",@"King's College London",@"Kingston University",@"Lancaster, The University of",@"Leeds College of Art",@"Leeds Beckett University",@"Leeds, The University of",@"Leeds Trinity University",@"Leicester, The University of",@"Lincoln, The University of",@"Liverpool Hope University",@"Liverpool John Moores University",@"Liverpool Institute for Performing Arts, The",@"Liverpool, The University of",@"Arts London, University of the",@"London Business School",@"London, University of (Institutes and activities)",@"London Metropolitan University",@"London South Bank University",@"London School of Economics and Political Science",@"London School of Hygiene and Tropical Medicine",@"Loughborough University",@"Manchester Metropolitan University, The",@"Manchester, The University of",@"Middlesex University",@"Newcastle-upon-Tyne, The University of",@"Newman University",@"Northampton, The University of",@"Northumbria at Newcastle, The University of",@"Norwich University of the Arts",@"Nottingham, The University of",@"Nottingham Trent University, The",@"Open University, The",@"Oxford Brookes University",@"Oxford, The University of",@"Plymouth, The University of",@"Portsmouth, The University of",@"Queen Mary University of London",@"Ravensbourne",@"Reading, The University of",@"Roehampton University",@"Rose Bruford College",@"Royal Academy of Music",@"Royal Agricultural University",@"Royal College of Art",@"Royal College of Music",@"Royal Holloway and Bedford New College",@"Royal Northern College of Music",@"Royal Veterinary College, The",@"St George's Hospital Medical School",@"St Mary's University College, Twickenham",@"Salford, The University of",@"School of Oriental and African Studies, The",@"Sheffield Hallam University",@"Sheffield, The University of",@"Southampton Solent University",@"Southampton, The University of",@"Staffordshire University",@"St Mark and St John, University of",@"Suffolk, University Campus",@"Sunderland, The University of",@"Surrey, The University of",@"Sussex, The University of",@"Teesside University",@"Trinity Laban Conservatoire of Music and Dance",@"University College London",@"Warwick, The University of",@"West of England, University of the",@"West London, The University of",@"Westminster, The University of",@"Winchester, The University of",@"Wolverhampton, The University of",@"Worcester, The University of",@"Writtle College",@"York St John University",@"York, The University of",@"Aberystwyth University",@"Bangor University",@"Cardiff University",@"Cardiff Metropolitan University",@"Glyndŵr University",@"Wales, Newport, The University of",@"Swansea University",@"Wales Trinity Saint David, University of",@"Aberdeen, The University of",@"Abertay Dundee, University of",@"Dundee, The University of",@"Edinburgh Napier University",@"Edinburgh, The University of",@"Glasgow Caledonian University",@"Glasgow School of Art",@"Glasgow, The University of",@"Heriot-Watt University",@"Queen Margaret University, Edinburgh",@"Robert Gordon University, The",@"Royal Conservatoire of Scotland",@"St Andrews, The University of",@"SRUC",@"Stirling, The University of",@"Strathclyde, The University of",@"Highlands and Islands, University of the",@"West of Scotland, The University of the",@"Queen's University of Belfast, The",@"St Mary's University College",@"Stranmillis University College",@"Ulster, University of", nil];
    
    
    self.sortedUniversities = [self.universitiesSortableNames sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    
    
    self.universitiesUKPRNS = [[NSMutableArray alloc] initWithObjects:@"10000291",@"10007759",@"10000571",@"10007850",@"10007152",@"10007760",@"10007140",@"10006840",@"10000712",@"10007811", @"10006841",@"10000385",@"10000824",@"10007785",@"10000886",@"10007786",@"10000961",@"10000975",@"10007787",@"10007788",@"10001143",@"10007141",@"10007816",@"10007848",@"10007137",@"10001478",@"10001653",@"10007761",@"10001726",@"10007822",@"10006427",@"10007842",@"10001883",@"10007851",@"10007143",@"10007789",@"10007144",@"10007823",@"10007791",@"10007792",@"10008640",@"10007145",@"10002718",@"10007146",@"10007825",@"10040812",@"10007147",@"10007765",@"10007148",@"10007149",@"10003270",@"10007766",@"10007767",@"10007150",@"10003645",@"10003678",@"10007768",@"10003854",@"10003861",@"10007795",@"10003863",@"10007796",@"10007151",@"10003956",@"10003957",@"10003945",@"10006842",@"10007162",@"10007769",@"10007797",@"10004048",@"10004078",@"10004063",@"10007771",@"10004113",@"10004180",@"10007798",@"10004351",@"10007799",@"10007832",@"10007138",@"10001282",@"10004775",@"10007154",@"10004797",@"10007773",@"10004930",@"10007774",@"10007801",@"10007155",@"10007775",@"10005389",@"10007802",@"10007776",@"10005523",@"10007835",@"10005545",@"10007777",@"10007778",@"10005553",@"10007837",@"10007779",@"10007782",@"10007843",@"10007156",@"10007780",@"10005790",@"10007157",@"10006022",@"10007158",@"10006299",@"10037449",@"10014001",@"10007159",@"10007160",@"10007806",@"10007161",@"10008017",@"10007784",@"10007163",@"10007164",@"10006566",@"10007165",@"10003614",@"10007166",@"10007139",@"10007657",@"10007713",@"10007167",@"10007856",@"10007857",@"10007814",@"10007854",@"10007833",@"10007853",@"10007855",@"10007858",@"10007783",@"10007849",@"10007852",@"10007772",@"10007790",@"10007762",@"10002681",@"10007794",@"10007764",@"10005337",@"10005500",@"10005561",@"10007803",@"10005700",@"10007804",@"10007805",@"10007114",@"10007800",@"10005343",@"10008026",@"10008010",@"10007807", nil];
    
    
    [self.sections removeAllObjects];
    
    BOOL found;
    
    for (NSString *temp in self.sortedUniversities)
    {
        //NSLog(@"temp: %@",temp);
        if (temp == (id)[NSNull null] || temp.length == 0 ) {
            //ignore it
        } else {
            NSString *c = [temp substringToIndex:1];
            
            found = NO;
            
            for (NSString *str in [self.sections allKeys])
            {
                if ([str isEqualToString:c])
                {
                    found = YES;
                }
            }
            
            
            if (!found)
            {
                [self.sections setValue:[[NSMutableArray alloc] init] forKey:c];
            }
            
            [[self.sections objectForKey:[temp substringToIndex:1]] addObject:temp];
        }
    }
    NSLog(@"sections: %@",sections);
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
        return self.sections.allKeys.count;
    } else {
        return 1;
    }
    // return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        //        NSString *letter = [self letterForSection:section];
        //        NSArray *rowIndecesInSection = [self.sections objectForKey:letter];
        //        return rowIndecesInSection.count;
        return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
    }
    else
    {
        //NSLog(@"%d", self.searchResults.count);
        
        return self.searchResults.count;
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
        
        [headerView setBackgroundColor:[UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f]];
        
        UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,self.view.bounds.size.width,22)];
        
        tempLabel.textColor = [UIColor whiteColor];
        tempLabel.text = [[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
        
        [headerView addSubview:tempLabel];
        return headerView;
    } else {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 2)];
        
        [headerView setBackgroundColor:[UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f]];
        
        return headerView;
    }
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
        return self.alphabetsArray;
        
    } else {
        return NULL;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSArray *universityFirstLetters = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"K",@"L",@"M",@"N",@"O",@"Q",@"R",@"S",@"T",@"U",@"W",@"Y", nil];
    return [universityFirstLetters indexOfObject:title];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //configure the cell
    if (tableView == self.tableView) {
        NSString *titleText = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        cell.textLabel.text = titleText;
        
    } else {
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    }
    cell.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    return cell;
}

#pragma mark - methods for search

- (void)filterContentForSearchText:(NSString*)searchText
{
    //NSLog(@"%@", _universityCourseNames);
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    
    self.searchResults = [self.sortedUniversities filteredArrayUsingPredicate:resultPredicate];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    return YES;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITabBarController *universityPageTabBarController = [[UITabBarController alloc] init];
    
    
    UniInfoCoursePageViewController *uniInfoCoursePageViewController = [[UniInfoCoursePageViewController alloc]init];
    
    CourseListTableViewController *courseListTableViewController = [[CourseListTableViewController alloc] initWithNibName:@"CourseListTableViewController" bundle:nil];
    
    OpenDaysUniversityPageTableViewController *openDaysUniversityPageTableViewController = [[OpenDaysUniversityPageTableViewController alloc] init];
    
    ContactUniversityPageViewController *contactUniversityPageViewController = [[ContactUniversityPageViewController alloc] init];
    
    
    
    universityPageTabBarController.viewControllers = [NSArray arrayWithObjects:uniInfoCoursePageViewController,courseListTableViewController,openDaysUniversityPageTableViewController,contactUniversityPageViewController,nil];
    [universityPageTabBarController.tabBar setSelectedImageTintColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f]];
    
    UILabel *universityTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (tableView != self.searchDisplayController.searchResultsTableView) {
        cell = [self.tableView cellForRowAtIndexPath:indexPath];
    } else {
        cell = [self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:indexPath];
    }
    
    universityTitle.numberOfLines = 2;
    universityTitle.text = cell.textLabel.text;
    universityTitle.textColor = [UIColor whiteColor];
    universityTitle.textAlignment = NSTextAlignmentCenter;
    universityPageTabBarController.navigationItem.titleView = universityTitle;
    universityPageTabBarController.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger originalIndexPath = [self.universitiesSortableNames indexOfObject:cell.textLabel.text];
    NSLog(@"orignial: %d",originalIndexPath);
    
    courseListTableViewController.universityCode = [universitiesUKPRNS objectAtIndex:originalIndexPath];
    contactUniversityPageViewController.universityCode = [universitiesUKPRNS objectAtIndex:originalIndexPath];
    openDaysUniversityPageTableViewController.universityUKPRN = [universitiesUKPRNS objectAtIndex:originalIndexPath];
    uniInfoCoursePageViewController.uniCodeUniInfo = [universitiesUKPRNS objectAtIndex:originalIndexPath];
    
    [self.navigationController pushViewController:universityPageTabBarController animated:YES];
    uniInfoCoursePageViewController.haveWeComeFromUniversities = YES;
    uniInfoCoursePageViewController.uniNameUniInfo = cell.textLabel.text;
    courseListTableViewController.universityName = cell.textLabel.text;
    contactUniversityPageViewController.universityName = cell.textLabel.text;
    
    
}

@end
