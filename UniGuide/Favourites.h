//
//  Favourites.h
//  UniGuide
//
//  Created by Andrew Paul on 08/08/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSManagedObject+CRUD.h"
#import <CoreData/CoreData.h>

@interface Favourites : NSManagedObject

@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSString *uniName;
@property (nonatomic,retain) NSString *courseCode;
@property (nonatomic,retain) NSString *uniCode;

@end
