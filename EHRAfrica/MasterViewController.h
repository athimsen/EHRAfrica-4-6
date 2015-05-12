//
//  MasterViewController.h
//  EHRAfrica
//
//  Created by Alec Thimsen on 4/27/15.
//  Copyright (c) 2015 Alec Thimsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class PersonalHxDetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) PersonalHxDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
