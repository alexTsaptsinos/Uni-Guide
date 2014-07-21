//
//  Courses.h
//  UniGuide
//
//  Created by Alex Tsaptsinos on 20/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Courses : NSObject

@property (nonatomic, retain) NSString *courseName;
@property (nonatomic, retain) NSString *university;

+ (NSMutableArray *) getAll;
+ (void) add: (Courses *)theObject;



@end
