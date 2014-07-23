//
//  UniversityBuilder.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UniversityBuilder : NSObject

+ (NSArray *)universitiesFromJSON:(NSData *)objectNotation error:(NSError **)error;


@end
