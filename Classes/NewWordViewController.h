//
//  NewWordViewController.h
//  Arabist2
//
//  Created by mark andrew on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MorphVC.h"
#import "TagButVC.h"

@protocol NewWordViewControllerDelegate;




@interface NewWordViewController : UIViewController <MorphVCDelegate /*, TagButVCDelegate */> {

	UITextField *englishField;
	UITextField *arabicField;
	UITextField *rootField;
	UITextField *contextField;
	
	NSManagedObjectContext *context;
	
	id <NewWordViewControllerDelegate> delegate;
	id editedObject;
	id editedMeaning;
	

}

- (IBAction) save;
- (IBAction) morph;
- (IBAction) buck;
- (IBAction) editTags;

- (void) setWord: (NSString *) word;


@property (nonatomic, retain) IBOutlet UITextField *englishField;
@property (nonatomic, retain) IBOutlet UITextField *arabicField;
@property (nonatomic, retain) IBOutlet UITextField *rootField;
@property (nonatomic, retain) IBOutlet UITextField *contextField;

@property (nonatomic, retain) id <NewWordViewControllerDelegate> delegate;
@property (nonatomic, retain) id editedObject;
@property (nonatomic, retain) id editedMeaning;

@property (nonatomic, retain) NSManagedObjectContext *context;

@end

@protocol NewWordViewControllerDelegate 

- (void) newWordViewController:(NewWordViewController *) controller didFinishWithSave:(BOOL) save; // Video 23:01

@end