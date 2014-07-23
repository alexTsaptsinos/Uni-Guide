//
//  UniversityCommunicator.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "UniversityCommunicator.h"
#import "UniversityCommunicatorDelegate.h"

#define API_KEY @"GLXMATX1ZCVS91MN1HYG:password"

@implementation UniversityCommunicator

-(void)searchAllUniversities
{
    NSString *urlAsString = [NSString stringWithFormat:@"http://%@@data.unistats.ac.uk/api/v2/KIS/Institutions.JSON?pageSize=415", API_KEY];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"This is the url: %@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            NSLog(@"error shit");
            [self.delegate fetchingUniversitiesFailedWithError:error];
        } else {
            NSLog(@"it's cool");
            [self.delegate receivedUniversitiesJSON:data];
        }
    }];
}

@end

// link to json data of list of institutions
// http://GLXMATX1ZCVS91MN1HYG:password@data.unistats.ac.uk/api/v2/KIS/Institutions.JSON?pageSize=415