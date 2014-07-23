//
//  UniversityBuilder.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 23/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "UniversityBuilder.h"
#import "University.h"
#import "UniversitiesListViewController.h"
#import "UniversitiesListTableViewController.h"

@implementation UniversityBuilder

+ (NSArray *)universitiesFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
 
    
    NSMutableArray *universities = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"Name"];
    NSLog(@"Count %d", results.count);
    
    for (NSDictionary *universityDic in results) {
        University *university = [[University alloc] init];
        university.name = [NSString stringWithFormat:@"%@", universityDic];
        NSLog(@"%@", university.name);
        
//        for (NSString *Name in universityDic) {
//            if ([university respondsToSelector:NSSelectorFromString(Name)]) {
//                [university setValue:[universityDic valueForKey:Name] forKey:Name];
//            }
//        }
        [universities addObject:university];
    }
    
    
    NSLog(@"This is our array of universities: %@", universities);
    NSLog(@"first row of array : %@", [universities objectAtIndex:1]);
    
    return universities;
}

@end
