//
//  Courses.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 20/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "Courses.h"

@implementation Courses

static NSMutableArray *allCourses;

+ (void)add: (Courses *)theObject{
    
    if ([allCourses count] ==0) {
        allCourses = [[NSMutableArray alloc] init];
    }
    
    [allCourses addObject:theObject];
}

+ (NSArray *) getAll {
    return allCourses;
}

@end
