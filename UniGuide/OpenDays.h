//
//  OpenDays.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 20/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenDays : NSObject

@property (nonatomic, strong) NSDate *openDayDate;
@property (nonatomic, strong) NSString *universityName;

+ (NSArray *) getAllOpenDays;
+ (void)add: (OpenDays *)theObject;

@end
