//
//  UniversityManager.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 22/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UniversityManagerDelegate.h"
#import "UniversityCommunicatorDelegate.h"

@class UniversityCommunicator;

@interface UniversityManager : NSObject<UniversityCommunicatorDelegate>

@property (strong, nonatomic) UniversityCommunicator *communicator;
@property (weak, nonatomic) id<UniversityManagerDelegate> delegate;

-(void)fetchAllUniversities;

@end
