//
//  NewWordViewController.m
//  Arabist2
//
//  Created by mark andrew on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NewWordViewController.h"


@implementation NewWordViewController
@synthesize englishField, arabicField, delegate, editedObject;

- (IBAction) save {
	[editedObject setValue:englishField.text forKey:@"english"];
	[editedObject setValue:arabicField.text forKey:@"arabic"];
	[delegate newWordViewController: self didFinishWithSave: YES];
	
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//[arabicField becomeFirstResponder];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	[editedObject release];
    [super dealloc];
}


@end
