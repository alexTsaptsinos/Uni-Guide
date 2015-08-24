//
//  CompareViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 17/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompareCollectionViewLayout.h"
#import "CompareCollectionViewCell.h"
#import "PieCompareCollectionViewCell.h"
#import "Compares.h"
#import "AddFromFavouritesTableViewController.h"
#import "ARSPopover.h"
#import "NSManagedObject+CRUD.h"

@interface CompareViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UICollectionView *compareCollectionView;
@property (strong,nonatomic) CompareCollectionViewLayout *layout;
@property (strong,nonatomic) Compares *courseObject;
@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (strong,nonatomic) ARSPopover *popoverController;

@property (nonatomic) BOOL isFirstTimeLoad;
@property (strong,nonatomic) NSArray *comparesArray;


//- (void)noComparesButtonClicked;
-(void) editBtnPressed;

@end
