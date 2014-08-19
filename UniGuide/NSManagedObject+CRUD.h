//
//  NSManagedObject+CRUD.h
//  EvolveMobile
//
//  Created by Karol Buczel on 19/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NSManagedObject(CRUD)

+ (NSString *)entityName;
+ (NSManagedObjectContext *)database;
+ (id)createObject;
+ (id)readOrCreateObjectWithParamterName:(NSString *)parameterName andValue:(id)parameterValue;
+ (id)readObjectWithParamterName:(NSString *)parameterName andValue:(id)parameterValue;
+ (NSArray*)readObjectsWithPredicate:(NSPredicate*)pred andSortKey:(NSString*)sortKey;
+ (id)readObjectWithPredicate:(NSPredicate*)pred andSortKey:(NSString*)sortKey;
+ (NSArray *)readAllObjects;
+ (void)removeAllObjects;
+ (void)deleteObject:(NSManagedObject *)object;
+ (BOOL)saveDatabase;

@end