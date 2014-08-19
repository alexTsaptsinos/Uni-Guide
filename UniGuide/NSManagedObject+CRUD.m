//
//  NSManagedObject+CRUD.m
//
//  Created by Luke McNeice on 19/03/2012.
//  Copyright (c) 2012 Kainos Software Ltd. All rights reserved.
//

#import "NSManagedObject+CRUD.h"
#import "AppDelegate.h"
#import <objc/runtime.h>


@implementation NSManagedObject(CRUD)


+ (NSManagedObjectContext *)database {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    return [delegate managedObjectContext];
}

+ (BOOL)saveDatabase {
    BOOL saveSuccessful = true;
    NSError *error;
    if (![[self database] save:&error]) {
        NSLog(@"Error saving changes to database - %@", error);
        saveSuccessful = false;
    }
    return saveSuccessful;
}

+ (NSString *)entityName {
    NSString *className = [NSString stringWithCString:class_getName([self class]) encoding:NSASCIIStringEncoding];
    NSRange rangeOfManagedObject = [className rangeOfString:@"ManagedObject"];
    
    NSString *entityName = (rangeOfManagedObject.location == NSNotFound) ? className :[className substringToIndex:rangeOfManagedObject.location];
    return entityName;
}

+ (id)createObject{
    NSString *className = [self entityName];
    
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:className inManagedObjectContext:[self database]];
    return obj; 
}

+ (id)readOrCreateObjectWithParamterName:(NSString *)parameterName andValue:(id)parameterValue {
    NSManagedObject *object = [self readObjectWithParamterName:parameterName andValue:parameterValue];
    
//    if ([GeneralUtils isEmpty:object]) {
//        object = [self createObject];
//    }
    
    return object;
}

+ (id)readObjectWithParamterName:(NSString *)parameterName andValue:(id)parameterValue {
    NSManagedObject *object = nil;
    
    NSString *className = [self entityName];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:className];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:parameterName ascending:YES];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", parameterName, parameterValue];
    
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    request.predicate = predicate;
    NSError *error;
    
    NSArray *results = [[self database] executeFetchRequest:request error: &error];
    
//    if ([GeneralUtils isntEmpty:results]) {
//        object = [results objectAtIndex:0];
//    }
    
    return object;    
}

+ (NSArray*)readObjectsWithPredicate:(NSPredicate*)pred andSortKey:(NSString*)sortKey {
    
    NSString *className = [self entityName];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:className];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:sortKey ascending:YES];
    
    
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    request.predicate = pred;
    NSError *error;
    
   return [[self database] executeFetchRequest:request error: &error];
}

+ (id)readObjectWithPredicate:(NSPredicate*)pred andSortKey:(NSString*)sortKey {
    
    NSString *className = [self entityName];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:className];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:sortKey ascending:YES];
    
    
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    request.predicate = pred;
    [request setFetchLimit:1];
    NSError *error;
    
    return [[[self database] executeFetchRequest:request error: &error] objectAtIndex:0];
}


+ (NSArray *)readAllObjects {
    NSString *className = [self entityName];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:className];
    NSError *error;
    
    NSArray *results = [[self database] executeFetchRequest:request error: &error];    

    return results;
}

+ (void)removeAllObjects {
    NSArray *objects = [self readAllObjects];
    
    for (NSManagedObject *obj in objects) {
        [[self database] deleteObject:obj];
    }
    
    [[self database] save:nil];
}

+ (void)deleteObject:(NSManagedObject *)object {
        [[self database] deleteObject:object];
}


@end