//
//  CommonJobsCompareViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 25/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompareCollectionViewLayout.h"
#import "CompareCollectionViewCell.h"
#import "CommonJobsCustomCellView.h"

@interface CommonJobsCompareViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UICollectionView *compareCollectionView;

@property (strong,nonatomic) UITableView *sectionTableView;
@property (strong,nonatomic) UITableView *firstCommonJobsTableView;
@property (strong,nonatomic) UITableView *secondCommonJobsTableView;
@property (strong,nonatomic) NSMutableArray *firstJobsArray;
@property (strong,nonatomic) NSMutableArray *secondJobsArray;
@property (strong,nonatomic) NSMutableArray *firstPercentagesArray;
@property (strong,nonatomic) NSMutableArray *secondPercentagesArray;
@property (strong,nonatomic) Compares *courseObject;



@end
