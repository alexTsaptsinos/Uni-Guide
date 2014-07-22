//
//  UniversityBuilder.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 22/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "UniversityBuilder.h"
#import "University.h"

@implementation UniversityBuilder

+ (NSArray *)universitiesFromJSON:(NSData *)objectNotation error:(NSError *__autoreleasing *)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *universities = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"results"];
    NSLog(@"Count %d", results.count);
    
    for (NSDictionary *universityDic in results) {
        University *university = [[University alloc]init];
        
        for (NSString *key in universityDic) {
            if ([university respondsToSelector:NSSelectorFromString(key)]) {
                [university setValue:[universityDic valueForKey:key] forKey:key];
            }
        }
        [universities addObject:university];
    }
    return universities;
}

@end

