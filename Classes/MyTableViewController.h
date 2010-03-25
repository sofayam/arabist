//
//  MyTableViewController.h
//  Arabist2
//
//  Created by mark andrew on 3/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewWordViewController.h"

@interface MyTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, NewWordViewControllerDelegate> {
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@end
