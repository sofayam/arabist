//
//  AddMeaningVC.m
//  Arabist2
//
//  Created by mark andrew on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AddMeaningVC.h"
#import "Meaning.h"

@implementation AddMeaningVC
@synthesize meaningField, contextField, meaningsModel, meaningsSet, context;

- (IBAction) addMeaning {
	
	Meaning *meaning = [NSEntityDescription insertNewObjectForEntityForName:@"Meaning"
																	   inManagedObjectContext:context];
	meaning.meaning = meaningField.text;
	meaning.context = contextField.text;
	[meaningsModel addObject: meaning];
	[meaningsSet addObject: meaning];
	
	NSError *error = nil;
	

	
	if (![context save:&error]) {
		//Replace this implementation with code to handle the error appropriately.
		
		//abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	
  // TODO refresh parent display	
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
    [super dealloc];
}


@end
