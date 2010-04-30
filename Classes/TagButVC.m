//
//  TagButVC.m
//  Arabist2
//
//  Created by mark andrew on 4/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TagButVC.h"
#import "Tag.h"


@implementation TagButVC
@synthesize butArr, butDict, delegate, context, fetchedResultsController;

UIAlertView *tagAlert;
UITextField *tagTextField;
UIButton *currentButton;

- (IBAction) createButtons {
	UIButton *tagButton;
	int bwidth = 100;
	int bheight = 30;
	int xoff = 10;
	int yoff = 10;
	int gap = 5;
	int i,j;
	
	self.butDict = [[NSMutableDictionary alloc] init];
	self.butArr = [[NSMutableArray alloc] init];
	
	for (j=0; j<12; j++) {
		for (i=0;i<3;i++) {

			tagButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
				
			tagButton.frame = CGRectMake(
										 xoff + (i*bwidth), 
										 yoff + (j*bheight), 
										 bwidth-gap, 
										 bheight-gap
										 );
			[tagButton setTitle:@"<undef>" forState:UIControlStateNormal];
			//[tagButton setTitle:@"Other" forState:UIControlEventTouchDown];
			[tagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
			[tagButton addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
			[tagButton addTarget:self action:@selector(touchDownRepeat:) forControlEvents:UIControlEventTouchDownRepeat];
			
			tagButton.backgroundColor = [UIColor clearColor];
			int tag = (i*100)+j;
			NSNumber *tagVal = [NSNumber numberWithInt: tag];
			tagButton.tag = tag;
			//stuff it in a dictionary
			[butDict setObject: tagButton forKey: tagVal];
			[self.view addSubview:tagButton];
			//and in an array
			[butArr addObject: tagButton];

		}
	}
	
	// Grab all the existing Tags from DB
	
	//NSArray *objs = [self fetchedResultsController].fetchedObjects;
	// And assign them to the buttons
	
	// Then look at which tags are set for the current word
	
	// and set the buttons for those tags
	
};
	 
- (void) tagAction: (id) sender {
	UIButton *resButton = (UIButton *) sender;
	NSLog(@"Pressed tag button %d", resButton.tag);
	[delegate addTag:resButton.currentTitle];

}


- (void) defineAction: (id) sender {
	UIButton *resButton = (UIButton *) sender;
	NSLog(@"Pressed define button %d", resButton.tag);
	
	// Ask for new name and assign to button (thanks to stackoverflow & BlueDolphin)
	tagAlert = [[UIAlertView alloc] initWithTitle:@"Define new Tag" message:@"This gets covered" 
													  delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	tagTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
	CGAffineTransform tagTransform = CGAffineTransformMakeTranslation(0.0, 130.0);
	[tagAlert setTransform:tagTransform];
	[tagTextField setBackgroundColor: [UIColor whiteColor]];
	[tagAlert addSubview:tagTextField];
	[tagAlert show];
	//NSLog(@"Alert returned with text", tagTextField.text);	
	
} 

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSLog(@"User Pressed Button %d with input %@\n", buttonIndex + 1, tagTextField.text);
	if (buttonIndex == 1) {
		[currentButton setTitle:tagTextField.text forState:UIControlStateNormal];
		[self addTag: tagTextField.text]; 
	}
	[tagTextField removeFromSuperview];
	[tagTextField release];
	[tagAlert release];
	
}

- (void) addTag: (NSString *) name {
	NSLog(@"Adding Tag with name %@", name);
	// Find out if this tag already exists - then simply set up the button
	Tag *tag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag"
													 inManagedObjectContext:context];
	tag.name = name;
	NSError *error = nil;
	if (![context save:&error]) {
		//Replace this implementation with code to handle the error appropriately.
		
		//abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
}


//- (void) alertView: (UIAlertView*) clickedButtonAtIndex:(NSInteger) buttonIndex {
//	NSLog(@"Clicked alert button %d", buttonIndex);
//}

//  Thanks to www.drobnik.com for this trick

- (void) touchDown: (id) sender {
	[self performSelector:@selector(tagAction:) withObject: sender afterDelay: 0.2];
}

- (void) touchDownRepeat: (id) sender {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(tagAction:) object:sender];
	currentButton = (UIButton *) sender;
	[self defineAction:sender];
}


 // The designated initializer.  Override if you create the controller programmatically and 
 // want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		[self createButtons];
        // Custom initialization
    }
    return self;
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    /*
	 Set up the fetched results controller.
	 */
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	
	// Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:20];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] 
								initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
	self.fetchedResultsController = aFetchedResultsController;
	
	[aFetchedResultsController release];
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
	return fetchedResultsController;
}    


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	
	// Grab all the existing Tags from DB
	NSError *error = nil;
	NSArray *objs = nil;
	[[self fetchedResultsController] performFetch:&error];
	objs = [self fetchedResultsController].fetchedObjects;
	
	NSLog(@"Found %d Tags", objs.count);
	
	if (!objs.count) { // Bung some stuff in there just to get things going
		NSLog(@"Filling up");
		Tag *tag1 = [NSEntityDescription insertNewObjectForEntityForName:@"Tag"
												 inManagedObjectContext:context]; 
		tag1.name = @"politics";
		Tag *tag2 = [NSEntityDescription insertNewObjectForEntityForName:@"Tag"
												 inManagedObjectContext:context]; 
		tag2.name = @"culture";		

		if (![context save:&error]) {
			//Replace this implementation with code to handle the error appropriately.
			
			//abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
		
		
		//NSArray *objs = [context executeFetchRequest:myrequest error:&error]
		//[[self fetchedResultsController] fetchRequest];
		[[self fetchedResultsController] performFetch:&error];
		objs = [self fetchedResultsController].fetchedObjects;
		NSLog(@"Found %d Tags", objs.count);
	}
	// And assign them to the buttons
	//NSArray *buts = [NSArray arrayWithArray: [butDict allValues]];
	int ctr = 0;
	for (Tag* tag in objs) {
		NSLog(@"Found Tag %@", tag.name);
		UIButton *but = (UIButton*) [butArr objectAtIndex:ctr]; 
		[but setTitle:tag.name forState:UIControlStateNormal];
		ctr++;
	}
	
	// Then look at which tags are set for the current word
	
	// and set the buttons for those tags
	

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
