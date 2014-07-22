//
//  UniversityManagerDelegate.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 22/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UniversityManagerDelegate

- (void)didReceiveUniversities:(NSArray *)universities;
- (void)fetchingUniversitiesFailedWithError:(NSError *)error;

@end
