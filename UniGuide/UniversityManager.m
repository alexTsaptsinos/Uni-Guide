//
//  UniversityManager.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "UniversityManager.h"
#import "UniversityCommunicator.h"
#import "UniversityBuilder.h"
#import "UniversitiesListTableViewController.h"

@implementation UniversityManager

@synthesize success;

- (void)fetchAllUniversities:(void (^)/*(BOOL success)*/(void))completetionBlock
{
    [self.communicator searchAllUniversities];
    
    //if (completetionBlock != nil) completetionBlock(universitiesSuccessful);
}

#pragma  mark - UniversityCommunicatorDelegate

-(void)receivedUniversitiesJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *universities = [UniversityBuilder universitiesFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        NSLog(@"error on way back");
        [self.delegate fetchingUniversitiesFailedWithError:error];
    } else {
        NSLog(@"alright and on way back");
        [self.delegate didReceiveUniversities:universities];
    }
    
    
}

- (void)fetchingUniversitiesFailedWithError:(NSError *)error
{
    [self.delegate fetchingUniversitiesFailedWithError:error];
}

@end
