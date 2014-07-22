//
//  UniversityCommunicatorDelegate.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 22/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UniversityCommunicatorDelegate

- (void)receivedUniversitiesJSON:(NSData *)objectNotation;
- (void)fetchingUniversitiesFailedWithError:(NSError *)error;

@end
