//
//  ViewController.m
//  CoreDataAudioIPhone
//
//  Created by Uwe Stahl on 07.08.13.
//  Copyright (c) 2013 Uwe Stahl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize audioFileList;
@synthesize fetchedResultsController,managedObjectContext, onlyAudioFiles;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *root = [[NSBundle mainBundle] bundlePath];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *dirContents = [fileMgr contentsOfDirectoryAtPath:root error:nil];
    NSPredicate *extFilter = [NSPredicate predicateWithFormat:@"self ENDSWITH '.wav'"];
    onlyAudioFiles = [dirContents filteredArrayUsingPredicate:extFilter];
    
    [self.audioFileList selectRow:1 inComponent:0 animated:NO];
}


-(void)insertNewManagedObject:(NSString *)fileName{
    
    // Create a new instance of the entity managed by the fetched results controller.
    
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    
    // If appropriate, configure the new managed object.
    
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    
    [newManagedObject setValue:fileName forKey:@"name"];
    
    [newManagedObject setValue:[self getAudioBinary:fileName] forKey:@"audioFile"];
    
    // Save the context.
    
    NSError *error = nil;
    
    if (![context save:&error])
        
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        abort();
        
    }
}


- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil)
    {
        return fetchedResultsController;
    }
    
    /*
     Set up the fetched results controller.
     */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Audios" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController;
}








-(NSData *)getAudioBinary:(NSString *)fileName{
    NSString *root = [[NSBundle mainBundle] bundlePath];
    NSString *filePath = [[NSString alloc] initWithString:[root stringByAppendingString:[@"/"stringByAppendingString:fileName]]];
    
    NSLog(@"%@",filePath);
    
    NSData *audioData = [[NSData alloc] initWithContentsOfFile:filePath];
    return audioData;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self insertNewManagedObject:[onlyAudioFiles objectAtIndex:row]];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [onlyAudioFiles count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    
    return [onlyAudioFiles objectAtIndex:row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
