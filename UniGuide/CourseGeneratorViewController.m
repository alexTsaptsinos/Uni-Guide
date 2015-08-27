//
//  CourseGeneratorViewController.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 06/08/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import "CourseGeneratorViewController.h"

@interface CourseGeneratorViewController ()

@end

@implementation CourseGeneratorViewController

@synthesize universityLabel,courseLabel,universitiesUKPRNS,universitiesSortableNames,universities,atLabel,goAgainButton,tryCourseButton,courseCodeCourseGenerator,uniCodeCourseGenerator,activityIndicator,favouritesButton,courseInfoCoursePageViewController,uniNameCourseGenerator,courseNameCourseGenerator;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Course Generator";
    self.view.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:238.0f/255.0f blue:238.0/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    
    CGFloat widthFloat = screenBound.size.width;
    CGFloat heightFloat = screenBound.size.height - self.navigationController.navigationBar.frame.size.height;
    
    universitiesUKPRNS = [[NSMutableArray alloc] initWithObjects:@"10000291",@"10007759",@"10000571",@"10007850",@"10007152",@"10007760",@"10007140",@"10006840",@"10000712",@"10007811", @"10006841",@"10000385",@"10000824",@"10007785",@"10000886",@"10007786",@"10000961",@"10000975",@"10007787",@"10007788",@"10001143",@"10007141",@"10007816",@"10007848",@"10007137",@"10001478",@"10001653",@"10007761",@"10001726",@"10007822",@"10006427",@"10007842",@"10001883",@"10007851",@"10007143",@"10007789",@"10007144",@"10007823",@"10007791",@"10007792",@"10008640",@"10007145",@"10002718",@"10007146",@"10007825",@"10040812",@"10007147",@"10007765",@"10007148",@"10007149",@"10003270",@"10007766",@"10007767",@"10007150",@"10003645",@"10003678",@"10007768",@"10003854",@"10003861",@"10007795",@"10003863",@"10007796",@"10007151",@"10003956",@"10003957",@"10003945",@"10006842",@"10007162",@"10007769",@"10007797",@"10004048",@"10004078",@"10004063",@"10007771",@"10004113",@"10004180",@"10007798",@"10004351",@"10007799",@"10007832",@"10007138",@"10001282",@"10004775",@"10007154",@"10004797",@"10007773",@"10004930",@"10007774",@"10007801",@"10007155",@"10007775",@"10005389",@"10007802",@"10007776",@"10005523",@"10007835",@"10005545",@"10007777",@"10007778",@"10005553",@"10007837",@"10007779",@"10007782",@"10007843",@"10007156",@"10007780",@"10005790",@"10007157",@"10006022",@"10007158",@"10006299",@"10037449",@"10014001",@"10007159",@"10007160",@"10007806",@"10007161",@"10008017",@"10007784",@"10007163",@"10007164",@"10006566",@"10007165",@"10003614",@"10007166",@"10007139",@"10007657",@"10007713",@"10007167",@"10007856",@"10007857",@"10007814",@"10007854",@"10007833",@"10007853",@"10007855",@"10007858",@"10007783",@"10007849",@"10007852",@"10007772",@"10007790",@"10007762",@"10002681",@"10007794",@"10007764",@"10005337",@"10005500",@"10005561",@"10007803",@"10005700",@"10007804",@"10007805",@"10007114",@"10007800",@"10005343",@"10008026",@"10008010",@"10007807", nil];
    
    universities = [[NSMutableArray alloc] initWithObjects:@"Anglia Ruskin University",@"Aston University",@"Bath Spa University",@"The University of Bath",@"University of Bedfordshire",@"Birkbeck College",@"Birmingham City University",@"The University of Birmingham",@"University College Birmingham",@"Bishop Grosseteste University",@"The University of Bolton",@"The Arts University Bournemouth",@"Bournemouth University",@"The University of Bradford",@"The University of Brighton",@"The University of Bristol",@"Brunel University",@"Buckinghamshire New University",@"The University of Buckingham",@"The University of Cambridge",@"Canterbury Christ Church University",@"The University of Central Lancashire",@"Central School of Speech and Drama",@"University of Chester",@"The University of Chichester",@"The City University",@"Conservatoire for Dance and Drama",@"Courtauld Institute of Art",@"Coventry University",@"Cranfield University",@"University for the Creative Arts",@"University of Cumbria",@"De Montfort University",@"University of Derby",@"University of Durham",@"The University of East Anglia",@"The University of East London",@"Edge Hill University",@"The University of Essex",@"The University of Exeter",@"Falmouth University",@"University of Gloucestershire",@"Goldsmiths College",@"The University of Greenwich",@"Guildhall School of Music and Drama",@"Harper Adams University",@"University of Hertfordshire",@"Heythrop College",@"The University of Huddersfield",@"The University of Hull",@"Imperial College of Science, Technology and Medicine",@"Institute of Education",@"The University of Keele",@"The University of Kent",@"King's College London",@"Kingston University",@"The University of Lancaster",@"Leeds College of Art",@"Leeds Beckett University",@"The University of Leeds",@"Leeds Trinity University",@"The University of Leicester",@"The University of Lincoln",@"Liverpool Hope University",@"Liverpool John Moores University",@"The Liverpool Institute for Performing Arts",@"The University of Liverpool",@"University of the Arts, London",@"London Business School",@"University of London (Institutes and activities)",@"London Metropolitan University",@"London South Bank University",@"London School of Economics and Political Science",@"London School of Hygiene and Tropical Medicine",@"Loughborough University",@"The Manchester Metropolitan University",@"The University of Manchester",@"Middlesex University",@"The University of Newcastle-upon-Tyne",@"Newman University",@"The University of Northampton",@"The University of Northumbria at Newcastle",@"Norwich University of the Arts",@"The University of Nottingham",@"The Nottingham Trent University",@"The Open University",@"Oxford Brookes University",@"The University of Oxford",@"The University of Plymouth",@"The University of Portsmouth",@"Queen Mary University of London",@"Ravensbourne",@"The University of Reading",@"Roehampton University",@"Rose Bruford College",@"Royal Academy of Music",@"Royal Agricultural University",@"Royal College of Art",@"Royal College of Music",@"Royal Holloway and Bedford New College",@"Royal Northern College of Music",@"The Royal Veterinary College",@"St George's Hospital Medical School",@"St Mary's University College, Twickenham",@"The University of Salford",@"The School of Oriental and African Studies",@"Sheffield Hallam University",@"The University of Sheffield",@"Southampton Solent University",@"The University of Southampton",@"Staffordshire University",@"University of St Mark and St John",@"University Campus Suffolk",@"The University of Sunderland",@"The University of Surrey",@"The University of Sussex",@"Teesside University",@"Trinity Laban Conservatoire of Music and Dance",@"University College London",@"The University of Warwick",@"University of the West of England, Bristol",@"The University of West London",@"The University of Westminster",@"The University of Winchester",@"The University of Wolverhampton",@"The University of Worcester",@"Writtle College",@"York St John University",@"The University of York",@"Aberystwyth University",@"Bangor University",@"Cardiff University",@"Cardiff Metropolitan University",@"Glyndŵr University",@"The University of Wales, Newport",@"Swansea University",@"University of Wales Trinity Saint David",@"The University of Aberdeen",@"University of Abertay Dundee",@"The University of Dundee",@"Edinburgh Napier University",@"The University of Edinburgh",@"Glasgow Caledonian University",@"Glasgow School of Art",@"The University of Glasgow",@"Heriot-Watt University",@"Queen Margaret University, Edinburgh",@"The Robert Gordon University",@"Royal Conservatoire of Scotland",@"The University of St Andrews",@"SRUC",@"The University of Stirling",@"The University of Strathclyde",@"University of the Highlands and Islands",@"The University of the West of Scotland",@"The Queen's University of Belfast",@"St Mary's University College",@"Stranmillis University College",@"University of Ulster", nil];
    
    universitiesSortableNames = [[NSMutableArray alloc] initWithObjects:@"Anglia Ruskin University",@"Aston University",@"Bath Spa University",@"Bath, The University of",@"Bedfordshire, University of",@"Birkbeck College",@"Birmingham City University",@"Birmingham, The University of",@"University College Birmingham",@"Bishop Grosseteste University",@"Bolton, The University of",@"Arts University Bournemouth, The",@"Bournemouth University",@"Bradford, The University of",@"Brighton, The University of",@"Bristol, The University of",@"Brunel University",@"Buckinghamshire New University",@"Buckingham, The University of",@"Cambridge, The University of",@"Canterbury Christ Church University",@"Central Lancashire, The University of",@"Central School of Speech and Drama",@"Chester, University of",@"Chichester, The University of",@"City University, The",@"Conservatoire for Dance and Drama",@"Courtauld Institute of Art",@"Coventry University",@"Cranfield University",@"University for the Creative Arts",@"Cumbria, University of",@"De Montfort University",@"Derby, University of",@"Durham, University of",@"East Anglia, The University of",@"East London, The University of",@"Edge Hill University",@"Essex, The University of",@"Exeter, The University of",@"Falmouth University",@"Gloucestershire, University of",@"Goldsmiths College",@"Greenwich, The University of",@"Guildhall School of Music and Drama",@"Harper Adams University",@"Hertfordshire, University of",@"Heythrop College",@"Huddersfield, The University of",@"Hull, The University of",@"Imperial College of Science, Technology and Medicine",@"Institute of Education",@"Keele, The University of",@"Kent, The University of",@"King's College London",@"Kingston University",@"Lancaster, The University of",@"Leeds College of Art",@"Leeds Beckett University",@"Leeds, The University of",@"Leeds Trinity University",@"Leicester, The University of",@"Lincoln, The University of",@"Liverpool Hope University",@"Liverpool John Moores University",@"Liverpool Institute for Performing Arts, The",@"Liverpool, The University of",@"Arts London, University of the",@"London Business School",@"London, University of (Institutes and activities)",@"London Metropolitan University",@"London South Bank University",@"London School of Economics and Political Science",@"London School of Hygiene and Tropical Medicine",@"Loughborough University",@"Manchester Metropolitan University, The",@"Manchester, The University of",@"Middlesex University",@"Newcastle-upon-Tyne, The University of",@"Newman University",@"Northampton, The University of",@"Northumbria at Newcastle, The University of",@"Norwich University of the Arts",@"Nottingham, The University of",@"Nottingham Trent University, The",@"Open University, The",@"Oxford Brookes University",@"Oxford, The University of",@"Plymouth, The University of",@"Portsmouth, The University of",@"Queen Mary University of London",@"Ravensbourne",@"Reading, The University of",@"Roehampton University",@"Rose Bruford College",@"Royal Academy of Music",@"Royal Agricultural University",@"Royal College of Art",@"Royal College of Music",@"Royal Holloway and Bedford New College",@"Royal Northern College of Music",@"Royal Veterinary College, The",@"St George's Hospital Medical School",@"St Mary's University College, Twickenham",@"Salford, The University of",@"School of Oriental and African Studies, The",@"Sheffield Hallam University",@"Sheffield, The University of",@"Southampton Solent University",@"Southampton, The University of",@"Staffordshire University",@"St Mark and St John, University of",@"Suffolk, University Campus",@"Sunderland, The University of",@"Surrey, The University of",@"Sussex, The University of",@"Teesside University",@"Trinity Laban Conservatoire of Music and Dance",@"University College London",@"Warwick, The University of",@"West of England, University of the",@"West London, The University of",@"Westminster, The University of",@"Winchester, The University of",@"Wolverhampton, The University of",@"Worcester, The University of",@"Writtle College",@"York St John University",@"York, The University of",@"Aberystwyth University",@"Bangor University",@"Cardiff University",@"Cardiff Metropolitan University",@"Glyndŵr University",@"Wales, Newport, The University of",@"Swansea University",@"Wales Trinity Saint David, University of",@"Aberdeen, The University of",@"Abertay Dundee, University of",@"Dundee, The University of",@"Edinburgh Napier University",@"Edinburgh, The University of",@"Glasgow Caledonian University",@"Glasgow School of Art",@"Glasgow, The University of",@"Heriot-Watt University",@"Queen Margaret University, Edinburgh",@"Robert Gordon University, The",@"Royal Conservatoire of Scotland",@"St Andrews, The University of",@"SRUC",@"Stirling, The University of",@"Strathclyde, The University of",@"Highlands and Islands, University of the",@"West of Scotland, The University of the",@"Queen's University of Belfast, The",@"St Mary's University College",@"Stranmillis University College",@"Ulster, University of", nil];
    
    UILabel *whyNotTryLabel = [[UILabel alloc] init];
    whyNotTryLabel.text = @"Why not try...";
    whyNotTryLabel.frame = CGRectMake(0, 30, widthFloat, 50);
    whyNotTryLabel.font = [UIFont fontWithName:@"Arial" size:18];
    whyNotTryLabel.textAlignment = NSTextAlignmentCenter;
    whyNotTryLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
    whyNotTryLabel.hidden = NO;
    whyNotTryLabel.numberOfLines = 1;
    whyNotTryLabel.alpha = 0;
    [self.view addSubview:whyNotTryLabel];
    [UIView animateWithDuration:0.8 animations:^{
        whyNotTryLabel.alpha = 1;
    } completion: ^(BOOL finished) {//creates a variable (BOOL) called "finished" that is set to *YES* when animation IS completed.
    }];
    
    courseLabel = [[UILabel alloc] init];
    courseLabel.frame = CGRectMake(15, 100, widthFloat-30, 80);
    courseLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:22];
    courseLabel.textAlignment = NSTextAlignmentCenter;
    courseLabel.textColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    courseLabel.alpha = 0;
    courseLabel.adjustsFontSizeToFitWidth = YES;
    courseLabel.numberOfLines = 0;
    [self.view addSubview:courseLabel];
    
    atLabel = [[UILabel alloc] init];
    atLabel.text = @"at";
    atLabel.frame = CGRectMake(0, 180, widthFloat, 50);
    atLabel.font = [UIFont fontWithName:@"Arial" size:18];
    atLabel.textAlignment = NSTextAlignmentCenter;
    atLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
    atLabel.alpha = 0;
    atLabel.numberOfLines = 1;
    [self.view addSubview:atLabel];
    
    universityLabel = [[UILabel alloc] init];
    universityLabel.frame = CGRectMake(15, 250, widthFloat-30, 50);
    universityLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    universityLabel.textAlignment = NSTextAlignmentCenter;
    universityLabel.textColor = [UIColor colorWithRed:42.0f/255.0f green:56.0f/255.0f blue:108.0f/255.0f alpha:1.0f];
    universityLabel.alpha = 0;
    universityLabel.numberOfLines = 0;
    universityLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:universityLabel];
    
    goAgainButton = [UIButton buttonWithType:UIButtonTypeSystem];
    goAgainButton.frame = CGRectMake(widthFloat/9, heightFloat - 170, widthFloat/3, 50);
    goAgainButton.exclusiveTouch = YES;
    [goAgainButton setTitle:@"Go again" forState:UIControlStateNormal];
    [goAgainButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goAgainButton addTarget:self action:@selector(goAgainBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [goAgainButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:goAgainButton];
    goAgainButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    CALayer *btnLayer = [goAgainButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:15.0f];
    goAgainButton.alpha = 0;
    
    
    tryCourseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    tryCourseButton.frame = CGRectMake(widthFloat*5/9, heightFloat - 170, widthFloat/3, 50);
    tryCourseButton.exclusiveTouch = YES;
    [tryCourseButton setTitle:@"More info" forState:UIControlStateNormal];
    [tryCourseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tryCourseButton addTarget:self action:@selector(tryCourseBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [tryCourseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:tryCourseButton];
    tryCourseButton.backgroundColor = [UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    btnLayer = [tryCourseButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:15.0f];
    tryCourseButton.alpha = 0;
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.frame = CGRectMake(widthFloat/2-10, 150, 20, 20);
    activityIndicator.hidesWhenStopped = YES;
    activityIndicator.hidden = NO;
    activityIndicator.alpha = 1;
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(generateCourse) userInfo:nil repeats:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)generateCourse {
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    
    CGFloat widthFloat = screenBound.size.width;
    
    int i = arc4random() % 159;
    NSLog(@"Random Number: %i", i);

    self.uniNameCourseGenerator = [universities objectAtIndex:i];
    universityLabel.text = uniNameCourseGenerator;

    uniCodeCourseGenerator = [universitiesUKPRNS objectAtIndex:i];
    
    PFQuery *bigQuery = [PFQuery queryWithClassName:@"Kiscourse"];
    [bigQuery whereKey:@"UKPRN" equalTo:uniCodeCourseGenerator];
    [bigQuery setLimit:1000];
    [bigQuery orderByAscending:@"TITLE"];
    [bigQuery findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
        if (!error) {
            if (objects.count == 0) {
                // NO OBJECTS - TRY AGAIN?
                [self generateCourse];
            } else {
                // THERE ARE OBJECTS
                NSArray *tempNames = [objects valueForKey:@"TITLE"];
                NSArray *tempCourseCodes = [objects valueForKey:@"KISCOURSEID"];
                NSArray *tempDegreeTitles = [objects valueForKey:@"CourseHonour"];
                NSUInteger numberOfCourses = tempNames.count;
                int k = arc4random() % numberOfCourses;
                NSString *courseNameTemp = [tempNames objectAtIndex:k];
                courseCodeCourseGenerator = [tempCourseCodes objectAtIndex:k];
                NSString *courseTitleTemp = [tempDegreeTitles objectAtIndex:k];
                
                courseNameTemp = [courseNameTemp stringByAppendingString:@" - "];
                courseNameCourseGenerator = [courseNameTemp stringByAppendingString:courseTitleTemp];
                courseLabel.text = courseNameCourseGenerator;
                NSLog(@"course name: %@",courseNameTemp);
                
                [UIView animateWithDuration:0.6 animations:^{
                    courseLabel.alpha = 1;
                } completion: ^(BOOL finished) {
                    if (finished) {
                        [UIView animateWithDuration:0.6 animations:^{
                            atLabel.alpha = 1;
                        } completion: ^(BOOL finished2) {
                            if (finished2) {
                                [UIView animateWithDuration:0.6 animations:^{
                                    universityLabel.alpha = 1;
                                } completion: ^(BOOL finished3) {
                                    if (finished3) {
                                        [UIView animateWithDuration:0.6 animations:^{
                                            goAgainButton.alpha = 1;
                                            tryCourseButton.alpha = 1;
                                        } completion: ^(BOOL finished4) {
                                            
                                        }];
                                    }
                                }];
                            }
                        }];
                    }
                }];
                [activityIndicator stopAnimating];
            }
            
        } else {
            // ERROR CODE HERE
            UIImageView *noInternetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90, widthFloat, 429)];
            noInternetImageView.backgroundColor = [UIColor lightGrayColor];
            UILabel *noInternetLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, widthFloat-150, 150)];
            noInternetLabel.text = @"We're sorry, but we can't generate you a course offline";
            noInternetLabel.numberOfLines = 0;
            noInternetLabel.textAlignment = NSTextAlignmentCenter;
            [noInternetImageView addSubview:noInternetLabel];
            [self.view addSubview:noInternetImageView];
            [activityIndicator stopAnimating];
            
        }
    }];
    
}

- (void)goAgainBtnClicked {
    courseLabel.alpha = 0;
    universityLabel.alpha = 0;
    atLabel.alpha = 0;
    goAgainButton.alpha = 0;
    tryCourseButton.alpha = 0;
    [activityIndicator startAnimating];
    [self generateCourse];
}

- (void)tryCourseBtnClicked {
    
    
    courseInfoCoursePageViewController = [[CourseInfoCoursePageViewController alloc] initWithNibName:@"CourseInfoCoursePageViewController" bundle:nil];
    
    StudentSatisfactionCoursePageViewController *studentSatisfactionCoursePageViewController = [[StudentSatisfactionCoursePageViewController alloc]initWithNibName:@"StudentSatisfactionCoursePageViewController" bundle:nil];
    
    ContactUniversityPageViewController*contactUniversityPageViewController = [[ContactUniversityPageViewController alloc] initWithNibName:@"ContactUniversityPageViewController" bundle:nil];
    
    UniInfoCoursePageViewController *uniInfoCoursePageViewController = [[UniInfoCoursePageViewController alloc] initWithNibName:@"UniInfoCoursePageViewController" bundle:nil];
    
    UITabBarController *coursePageTabBarController = [[UITabBarController alloc] initWithNibName:@"CoursePageTabBarController" bundle:nil];
    
    coursePageTabBarController.viewControllers = [NSArray arrayWithObjects:courseInfoCoursePageViewController,studentSatisfactionCoursePageViewController,uniInfoCoursePageViewController,contactUniversityPageViewController,nil];
    
    // Pass the selected object to the new view controller.
    
    coursePageTabBarController.navigationItem.title = @"Course";
    coursePageTabBarController.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [coursePageTabBarController.tabBar setSelectedImageTintColor:[UIColor colorWithRed:198.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f]];
    
    courseInfoCoursePageViewController.uniCodeCourseInfo = self.uniCodeCourseGenerator;
    uniInfoCoursePageViewController.uniCodeUniInfo = self.uniCodeCourseGenerator;
    contactUniversityPageViewController.universityCode = self.uniCodeCourseGenerator;
    studentSatisfactionCoursePageViewController.uniCodeStudentSatisfaction = self.uniCodeCourseGenerator;
    
    NSArray * temp2 = [Favourites readObjectsWithPredicate:[NSPredicate predicateWithFormat:@"(courseCode = %@) AND (uniCode = %@)",courseCodeCourseGenerator,uniCodeCourseGenerator] andSortKey:@"courseName"];
    if (temp2.count != 0) {
        favouritesButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_to_favorites-512.png"] style:UIBarButtonItemStylePlain target:self action:@selector(callAnotherMethod)];
        favouritesButton.tintColor = [UIColor colorWithRed:233.0f/255.0f green:174.0f/255.0f blue:28.0f/255.0f alpha:1.0f];
        [coursePageTabBarController.navigationItem setRightBarButtonItem:favouritesButton];
        courseInfoCoursePageViewController.isItFavourite = YES;
    } else {
        favouritesButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_to_favorites-512.png"] style:UIBarButtonItemStylePlain target:self action:@selector(callAnotherMethod)];
        favouritesButton.tintColor = [UIColor whiteColor];
        [coursePageTabBarController.navigationItem setRightBarButtonItem:favouritesButton];
        courseInfoCoursePageViewController.isItFavourite = NO;
    }
    
    
    courseInfoCoursePageViewController.courseCodeCourseInfo = courseCodeCourseGenerator;
    courseInfoCoursePageViewController.courseNameCourseInfo = courseNameCourseGenerator;
    courseInfoCoursePageViewController.uniNameCourseInfo = uniNameCourseGenerator;
    courseInfoCoursePageViewController.haveComeFromFavourites = NO;
    
    contactUniversityPageViewController.universityName = uniNameCourseGenerator;
    contactUniversityPageViewController.courseCodeContact = courseCodeCourseGenerator;
    contactUniversityPageViewController.haveWeComeFromUniversities = NO;
    
    studentSatisfactionCoursePageViewController.courseCodeStudentSatisfaction = courseCodeCourseGenerator;
    studentSatisfactionCoursePageViewController.courseNameStudentSatisfaction = courseNameCourseGenerator;
    studentSatisfactionCoursePageViewController.uniNameStudentSatisfaction = uniNameCourseGenerator;
    
    uniInfoCoursePageViewController.haveWeComeFromUniversities = NO;
    uniInfoCoursePageViewController.uniNameUniInfo = uniNameCourseGenerator;
    uniInfoCoursePageViewController.courseCodeUniInfo = courseCodeCourseGenerator;
    
    // Push the view controller.
    [self.navigationController pushViewController:coursePageTabBarController animated:YES];
    
    
    
    
    
}

-(void) callAnotherMethod {
    
    courseInfoCoursePageViewController.favouritesButton = self.favouritesButton;
    [courseInfoCoursePageViewController customBtnPressed];
}


@end
