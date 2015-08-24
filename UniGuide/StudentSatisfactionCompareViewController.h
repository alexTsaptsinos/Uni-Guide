//
//  StudentSatisfactionCompareViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 25/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompareCollectionViewLayout.h"
#import "CompareCollectionViewCell.h"
#import "Compares.h"
#import "AddFromFavouritesTableViewController.h"

@interface StudentSatisfactionCompareViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UICollectionView *compareCollectionView;
@property (strong,nonatomic) NSArray *questionResults;
@property (strong,nonatomic) NSArray *questionResults2;
@property (strong,nonatomic) Compares *courseObject;


@end
