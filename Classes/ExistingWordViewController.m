//
//  ExistingWordViewController.m
//  Arabist2
//
//  Created by mark andrew on 3/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ExistingWordViewController.h"


@implementation ExistingWordViewController

@synthesize scr, f1, f2;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


#pragma mark -
#pragma mark Keyboard Mallarkey

// All stolen from Head First Book - why the flying f*ck do I have to do this myself?
- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
												 name: UIKeyboardDidShowNotification
											   object: nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
												 name: UIKeyboardDidHideNotification
											   object: nil];
	keyboardVisible = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
	NSLog(@"unreg for kb events");
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)keyboardDidShow: (NSNotification *) notif {
	NSLog(@"Show kb");
	if (keyboardVisible) return;
	NSDictionary * info = [notif userInfo];
	NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
	CGSize keyboardSize = [aValue CGRectValue].size;
	
	CGRect viewFrame = self.view.frame;
	viewFrame.size.height -= keyboardSize.height;
	scr.frame = viewFrame;
	keyboardVisible = YES;
}
- (void)keyboardDidHide: (NSNotification *) notif {
	NSLog(@"Hide kb");
	if(!keyboardVisible) return;
	NSDictionary * info = [notif userInfo];
	NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
	CGSize keyboardSize = [aValue CGRectValue].size;
	CGRect viewFrame = self.view.frame;
	viewFrame.size.height += keyboardSize.height;
	scr.frame = viewFrame;
	keyboardVisible = NO;
	
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	scr.contentSize = self.view.frame.size;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Memory Mgt



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[scr release];
	[f1 release];
	[f2 release];
    [super dealloc];
}


@end
