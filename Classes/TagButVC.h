//
//  TagButVC.h
//  Arabist2
//
//  Created by mark andrew on 4/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"
/*
@protocol TagButVCDelegate;
*/

@interface TagButVC : UIViewController <UIAlertViewDelegate, NSFetchedResultsControllerDelegate> {
	NSMutableDictionary *butDict;
	NSMutableArray *butArr;
	/*id <TagButVCDelegate> delegate;*/
	Entry *entry;
	NSManagedObjectContext *context;
	NSFetchedResultsController *fetchedResultsController;
}

- (void) createButtons;
- (void) addTag: (NSString *) name forButton: (NSNumber*) button;

@property (nonatomic, retain) NSMutableArray *butArr;
@property (nonatomic, retain) NSMutableDictionary *butDict;
@property (nonatomic, retain) Entry *entry;
/*@property (nonatomic, retain) id <TagButVCDelegate> delegate;*/
@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;


@end

/*
@protocol TagButVCDelegate

- (void) addTag: (NSString *) tag;

@end
*/
