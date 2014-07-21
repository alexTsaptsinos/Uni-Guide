//
//  Universities.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 21/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Universities : NSObject {
    
    NSString *universityName;
    NSString *townOrCampus;
}


@property (nonatomic, strong) NSString *universityName;
@property (nonatomic, strong) NSString *townOrCampus;

+ (id)universityOfTownOrCampus:(NSString*)townOrCampus universityName:(NSString*)universityName;


@end
