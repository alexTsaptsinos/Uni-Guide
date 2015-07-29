//
//  Compares.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 29/07/2015.
//  Copyright (c) 2015 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSManagedObject+CRUD.h"
#import <CoreData/CoreData.h>

@interface Compares : NSManagedObject

@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSString *uniName;
@property (nonatomic,retain) NSString *courseCode;
@property (nonatomic,retain) NSString *uniCode;

@property (nonatomic,retain) NSString *yearAbroad;
@property (nonatomic,retain) NSString *sandwichYear;
@property (nonatomic,retain) NSString *ucasCode;
@property (nonatomic,retain) NSString *courseUrl;
@property (nonatomic,retain) NSData *degreeClasses;
@property (nonatomic,retain) NSString *averageTariffString;
@property (nonatomic,retain) NSData *assessmentMethods;
@property (nonatomic,retain) NSData *timeSpent;
@property (nonatomic,retain) NSString *proportionInWork;
@property (nonatomic,retain) NSData *commonJobs;
@property (nonatomic,retain) NSData *commonJobsPercentages;
@property (nonatomic,retain) NSString *instituteSalary;
@property (nonatomic,retain) NSString *nationalSalary;
@property (nonatomic,retain) NSNumber *sortNumber;

@property (nonatomic,retain) NSData *nSSScores;
@property (nonatomic,retain) NSData *uniInfoData;
@property (nonatomic,retain) NSString *unionSatisfaction;

@end
