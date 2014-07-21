//
//  OpenDays.m
//  UniGuide
//
//  Created by Alex Tsaptsinos on 20/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "OpenDays.h"

@implementation OpenDays

static NSMutableArray *allOpenDays;

+ (void)add: (OpenDays *)theObject{
    
    if ([allOpenDays count] ==0) {
        allOpenDays = [[NSMutableArray alloc] init];
    }
    
    [allOpenDays addObject:theObject];
}

+ (NSArray *) getAllOpenDays {
    return allOpenDays;
}

@end
