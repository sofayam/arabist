//
//  NewWordViewController.m
//  Arabist2
//
//  Created by mark andrew on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NewWordViewController.h"
#import "MorphVC.h"
#import "buck.h"


@implementation NewWordViewController
@synthesize context, englishField, arabicField, contextField, rootField, delegate, editedObject, editedMeaning;

- (void) setWord: (NSString *) word {
	arabicField.text = word;
	NSLog(@"Called Delegate method setWord");
}

/*
- (void) addTag: (NSString *) tag {
	
}
*/

// TODO Refactor

- (IBAction) editTags {
	NSLog(@"clicking on tags");
	// Push a table view
	// Give him the tags
	TagButVC *tagButVC = [[TagButVC alloc]
						  initWithNibName:@"TagButVC" 
						  bundle:nil];
	/*tagButVC.delegate = self;*/
	tagButVC.context = context;
	tagButVC.entry = editedObject;
	[self.navigationController pushViewController:tagButVC animated:YES] ;
	[tagButVC release];
	
};


- (IBAction) buck {
	rootField.text = [buck getArabFromBuck: rootField.text];
	arabicField.text = [buck getArabFromBuck: arabicField.text];
}

- (IBAction) save {
	//[editedObject setValue:englishField.text forKey:@"english"]; // navigate to meaning & create object
	[self buck];
	
	[editedObject setValue:arabicField.text forKey:@"word"];
	[editedObject setValue:rootField.text forKey:@"root"];
	[editedObject setValue:@"morphdummy" forKey:@"morph"];
	
	NSMutableSet *meanset = [editedObject mutableSetValueForKey:@"meanings"];
	
	[editedMeaning setValue:englishField.text forKey:@"meaning"];
	[editedMeaning setValue:contextField.text forKey:@"context"]; //TODO not picking this up for some reason
	
	[meanset addObject: editedMeaning];
	
	//[editedObject addMeaningsObject: editedMeaning];
	//[editedObject setValue:englishField.text forKey:"meanings"];

	[delegate newWordViewController: self didFinishWithSave: YES];
	
	
}

- (IBAction) morph {

	if (rootField.text == @"") return; //TODO Check it isn't empty and complain otherwise
	MorphVC *morphVC = [[MorphVC alloc] initWithNibName: @"MorphVC" bundle: nil];
	morphVC.root = rootField.text; 
	morphVC.delegate = self;
	
	[self.navigationController pushViewController:morphVC animated:YES] ;
	[morphVC release];

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
