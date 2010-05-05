//
//  TagButVC.m
//  Arabist2
//
//  Created by mark andrew on 4/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TagButVC.h"
#import "Tag.h"

const int maxi = 3;
const int maxj = 12;

@implementation TagButVC
@synthesize butArr, butDict, entry, context, fetchedResultsController;

UIAlertView *tagAlert;
UITextField *tagTextField;
UIButton *currentButton;

- (void) flushToDB {

	NSError *error = nil;
	if (![context save:&error]) {
		//Replace this implementation with code to handle the error appropriately.
	
		//abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
	
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
}


- (NSArray*) getTagsFromDB {
	NSError *error = nil;
	[[self fetchedResultsController] performFetch:&error];
	return [self fetchedResultsController].fetchedObjects;
}

- (Tag*) getTagFromDBWithName: (NSString*) name {
	NSArray *objs = [self getTagsFromDB];
	NSString *tagName;
	for (Tag* tag in objs) {
		NSLog(@"Comparing %@ with %@", tag.name, name);
		tagName = tag.name;
		if ([tag.name isEqual: name]) {
			return tag;
		}
	}
	return nil;
	// TODO Error handling
}

- (int) butTagi:(int) i butTagj:(int) j {
	return (i*100)+j;
}

- (NSNumber*) butKeyi:(int) i  butKeyj:(int) j {
	int tag = [self butTagi: i butTagj: j];
	return [NSNumber numberWithInt:tag]; 
}

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
	
	for (j=0; j<maxj; j++) {
		for (i=0;i<maxi;i++) {

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
			int tag = [self butTagi: i butTagj: j];
			//NSString *tagVal = [NSString stringWithFormat:@"%d", tag];
			tagButton.tag = tag; //TODO do we really need tags (in the Cocoa sense?)
			//stuff it in a dictionary
			[butDict setObject: tagButton forKey: [NSNumber numberWithInt: tag]];
			[self.view addSubview:tagButton];
			//and in an array
			[butArr addObject: tagButton];

		}
	}

	
};
	 
- (void) tagAction: (id) sender {
	UIButton *resButton = (UIButton *) sender;
	NSLog(@"Pressed tag button %d", resButton.tag);
	/*[delegate addTag:resButton.currentTitle];*/
	
	// Now actually add a tag to an entry
	NSString *lab = resButton.currentTitle;
	Tag* tag = [self getTagFromDBWithName:lab];
	
	/*
	NSNumber *num = [NSNumber numberWithInt: currentButton.tag];
	UIButton *but = [butDict objectForKey:num];
	 */
	if (tag) {
		[entry addTagsObject: tag];
		/*[butDict objectForKey: [NSNumber numberWithInt: currentButton.tag]]];*/
		[self flushToDB];
	}
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
		[self addTag: tagTextField.text forButton: [NSNumber numberWithInt: currentButton.tag]]; 
	}
	[tagTextField removeFromSuperview];
	[tagTextField release];
	[tagAlert release];
	
}

- (void) addTag: (NSString *) name forButton: (NSNumber*) button{
	NSLog(@"Adding Tag with name %@", name);
	// Find out if this tag already exists - then simply set up the button
	Tag *tag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag"
													 inManagedObjectContext:context];
	tag.name = name;
	tag.button = button;
	
	[self flushToDB];	
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

	NSArray *objs = nil;
	
	objs = [self getTagsFromDB];
//	[[self fetchedResultsController] performFetch:&error];
//	objs = [self fetchedResultsController].fetchedObjects;
	
	NSLog(@"Found %d Tags", objs.count);
	
	if (!objs.count) { // Bung some stuff in there just to get things going
		NSLog(@"Filling up");
		Tag *tag1 = [NSEntityDescription insertNewObjectForEntityForName:@"Tag"
												 inManagedObjectContext:context]; 
		tag1.name = @"politics";
		tag1.button = [self butKeyi:0 butKeyj:0];
		Tag *tag2 = [NSEntityDescription insertNewObjectForEntityForName:@"Tag"
												 inManagedObjectContext:context]; 
		tag2.name = @"culture";	
		tag2.button = [self butKeyi:1 butKeyj:0];


		[self flushToDB];
		
		
		//NSArray *objs = [context executeFetchRequest:myrequest error:&error]
		//[[self fetchedResultsController] fetchRequest];
		//[[self fetchedResultsController] performFetch:&error];
		//objs = [self fetchedResultsController].fetchedObjects;
		objs = [self getTagsFromDB];
		NSLog(@"Found %d Tags", objs.count);
	}
	// And assign them to the buttons
	//NSArray *buts = [NSArray arrayWithArray: [butDict allValues]];
	int ctr = 1;
	for (Tag* tag in objs) {
		NSLog(@"Found Tag %@ %@", tag.name, tag.button);
		
		UIButton *but = (UIButton*) [butDict objectForKey: tag.button]; 
		
		//UIButton *but = (UIButton*) [butArr objectAtIndex: [Number tag.button]; 
		
		[but setTitle:tag.name forState:UIControlStateNormal];
		ctr++;
		if (ctr > maxi*maxj) break;
	}
	
	
	// Grab all the existing Tags from DB for current word
	// and set the buttons for those tags to special color
	
	for (Tag* tag in entry.tags) {
		[[butDict objectForKey: tag.button] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	}
	

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
