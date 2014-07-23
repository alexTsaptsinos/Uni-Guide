//
//  UniversityManagerDelegate.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UniversityManagerDelegate <NSObject>
-(void)didReceiveUniversities:(NSArray *)universities;
-(void)fetchingUniversitiesFailedWithError:(NSError *)error;

@end
