//
//  UniversityManager.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 22/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "UniversityManager.h"
#import "UniversityBuilder.h"
#import "UniversityCommunicator.h"

@implementation UniversityManager

-(void)fetchAllUniversities
{
    [self.communicator searchAllUniversities];
    
}

#pragma mark - UniversityCommunicatorDelegate

-(void)receivedUniversitiesJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *universities = [UniversityBuilder universitiesFromJSON:objectNotation error:&error];
    
    if (error !=nil) {
        [self.delegate fetchingUniversitiesFailedWithError:error];
    } else {
        [self.delegate didReceiveUniversities:universities];
    }
}

- (void)fetchingUniversitiesFailedWithError:(NSError *)error
{
    [self.delegate fetchingUniversitiesFailedWithError:error];
}

@end
