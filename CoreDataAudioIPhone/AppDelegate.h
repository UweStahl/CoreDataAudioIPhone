//
//  AppDelegate.h
//  CoreDataAudioIPhone
//
//  Created by Uwe Stahl on 07.08.13.
//  Copyright (c) 2013 Uwe Stahl. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class ViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

@end