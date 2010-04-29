//
//  ExistingWordViewController.h
//  Arabist2
//
//  Created by mark andrew on 3/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"
#import "TagButVC.h"

@interface ExistingWordViewController : UIViewController <TagButVCDelegate> {
	
	IBOutlet UITextField *root;
	IBOutlet UITextField *word;
	IBOutlet UIScrollView *scr;
	IBOutlet UITextView *meanings;
	IBOutlet UITextView *tags;

	BOOL keyboardVisible;
	Entry *entry;
	NSManagedObjectContext *context;
}

- (IBAction) editMeanings;
- (IBAction) editTags;

- (void)keyboardDidShow: (NSNotification *) notif;
- (void)keyboardDidHide: (NSNotification *) notif;
- (void)refreshMeanings;


@property (nonatomic, retain) UITextField *root;
@property (nonatomic, retain) UITextField *word;
@property (nonatomic, retain) UIScrollView *scr;
@property (nonatomic, retain) UITextView *meanings;
@property (nonatomic, retain) UITextView *tags;
@property (nonatomic, retain) Entry *entry;
@property (nonatomic, retain) NSManagedObjectContext *context;

@end
