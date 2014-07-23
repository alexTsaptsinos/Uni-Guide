//
//  UniversityCommunicatorDelegate.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UniversityCommunicatorDelegate <NSObject>

- (void)receivedUniversitiesJSON:(NSData *)objectNotation;
- (void)fetchingUniversitiesFailedWithError:(NSError *)error;

@end
