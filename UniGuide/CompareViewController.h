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

@interface CompareViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UICollectionView *compareCollectionView;
@property (strong,nonatomic) Compares *courseObject;

- (void)noComparesButtonClicked;

@end
