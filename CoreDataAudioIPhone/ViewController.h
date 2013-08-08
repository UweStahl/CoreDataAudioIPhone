//
//  ViewController.h
//  CoreDataAudioIPhone
//
//  Created by Uwe Stahl on 07.08.13.
//  Copyright (c) 2013 Uwe Stahl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSFetchedResultsControllerDelegate,UIPickerViewDelegate,
UIPickerViewDataSource>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray *onlyAudioFiles;
@property (strong, nonatomic) IBOutlet UIPickerView *audioFileList;

-(NSData *)getAudioBinary:(NSString *)fileName;
-(void)insertNewManagedObject:(NSString *)fileName;


@end
