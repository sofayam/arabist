//
//  ExistingWordViewController.m
//  Arabist2
//
//  Created by mark andrew on 3/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ExistingWordViewController.h"
#import "Meaning.h"
#import "MeaningVC.h"
#import "TagButVC.h"

@implementation ExistingWordViewController

@synthesize root, word, meanings, tags, scr, entry, context;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (void) addTag: (NSString *) tag {
	NSLog(@"Adding Tag %@", tag);
}

- (IBAction) editMeanings {
	NSLog(@"clicking on meanings");
	
	MeaningVC *meaningVC = [[MeaningVC alloc]
						initWithNibName:@"MeaningVC" 
						bundle:nil];
	// create array of meanings
	meaningVC.context = context;
	meaningVC.meaningsModel = [[NSMutableArray alloc] init];
	meaningVC.meaningsSet = [entry mutableSetValueForKey:@"meanings"];
	
	for (Meaning *meaning in entry.meanings) {
		[meaningVC.meaningsModel addObject:meaning];
	}
		
	
	[self.navigationController pushViewController:meaningVC animated:YES] ;
	[meaningVC release];
}
- (IBAction) editTags {
	NSLog(@"clicking on tags");
	// Push a table view
	// Give him the tags
	TagButVC *tagButVC = [[TagButVC alloc]
						  initWithNibName:@"TagButVC" 
						  bundle:nil];
	tagButVC.delegate = self;
	tagButVC.context = context;
	[self.navigationController pushViewController:tagButVC animated:YES] ;
	[tagButVC release];
	
};



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

- (void) refreshMeanings {
	NSMutableArray *nma = [[NSMutableArray alloc] init];
	NSString *mng = nil; //TODO string equality wierdness
	for (Meaning *meaning in entry.meanings) {
//		if (mng != @"") {
//			mng = [NSString stringWithFormat:@"%@, ", mng]; 
//		}
		if (meaning.context && (meaning.context != @"")) {
			mng = [NSString stringWithFormat:@"%@(%@)", meaning.meaning, meaning.context];
		} else {
			mng = [NSString stringWithFormat:@"%@", meaning.meaning];
		}
		[nma addObject: mng];
	}
	meanings.text = [nma componentsJoinedByString:@", "];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	scr.contentSize = self.view.frame.size;
	// set up root, word and meanings
	root.text = entry.root;
	word.text = entry.word;
	//NSString *mng = @"";  //TODO string equality wierdness
	[self refreshMeanings];
}

- (void) viewDidAppear: (BOOL)animated {
	[super viewDidAppear: animated];
	[self refreshMeanings];
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
	[root release];
	[word release];
	[meanings release];
	[tags release];
//	[entry release];
    [super dealloc];
}


@end
