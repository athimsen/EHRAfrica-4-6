//
//  AppDelegate.h
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/11/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import "Patient.h"
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSURL *storeUrl;

@property (strong, nonatomic) NSMutableDictionary *patientLookupById;
@property (strong, nonatomic) NSMutableDictionary *patientLookupByName;

@property (weak, nonatomic) Patient *currentPatient;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

