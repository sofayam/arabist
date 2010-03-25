//
//  NewWordViewController.h
//  Arabist2
//
//  Created by mark andrew on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewWordViewControllerDelegate;




@interface NewWordViewController : UIViewController {

	UITextField *englishField;
	UITextField *arabicField;
	
	id <NewWordViewControllerDelegate> delegate;
	id editedObject;
}

- (IBAction) save;

@property (nonatomic, retain) IBOutlet UITextField *englishField;
@property (nonatomic, retain) IBOutlet UITextField *arabicField;
@property (nonatomic, retain) id <NewWordViewControllerDelegate> delegate;
@property (nonatomic, retain) id editedObject;

@end

@protocol NewWordViewControllerDelegate 

- (void) newWordViewController:(NewWordViewController *) controller didFinishWithSave:(BOOL) save; // Video 23:01

@end