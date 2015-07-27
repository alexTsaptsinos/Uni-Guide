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

@interface StudentSatisfactionCompareViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UICollectionView *compareCollectionView;
@property (strong,nonatomic) NSArray *questionResults1;
@property (strong,nonatomic) NSArray *questionResults2;

@end
