//
//  Universities.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 21/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "Universities.h"

@implementation Universities

@synthesize universityName,townOrCampus;

+ (id)universityOfTownOrCampus:(NSString*)townOrCampus universityName:(NSString*)universityName{
    
    Universities *newUniversity = [[self alloc] init];
    newUniversity.universityName = universityName;
    newUniversity.townOrCampus = townOrCampus;
    return newUniversity;
    
}

@end
