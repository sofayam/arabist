//
//  TagButVC.m
//  Arabist2
//
//  Created by mark andrew on 4/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TagButVC.h"


@implementation TagButVC
@synthesize butDict;

- (IBAction) create {
	UIButton *tagButton;
	int bwidth = 100;
	int bheight = 30;
	int xoff = 10;
	int yoff = 10;
	int gap = 5;
	int i,j;
	
	self.butDict = [[NSMutableDictionary alloc] init];

	
	for (i=0;i<3;i++) {
		for (j=0; j<12; j++) {
			
		

			tagButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
				
			tagButton.frame = CGRectMake(
										 xoff + (i*bwidth), 
										 yoff + (j*bheight), 
										 bwidth-gap, 
										 bheight-gap
										 );
			[tagButton setTitle:@"" forState:UIControlStateNormal];
			//[tagButton setTitle:@"Other" forState:UIControlEventTouchDown];
			[tagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
			[tagButton addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchUpInside];
			[tagButton addTarget:self action:@selector(touchDownRepeat:) forControlEvents:UIControlEventTouchDownRepeat];
			
			tagButton.backgroundColor = [UIColor clearColor];
			int tag = (i*100)+j;
			NSNumber *tagVal = [NSNumber numberWithInt: tag];
			tagButton.tag = tag;
			//stuff it in a dictionary
			[butDict setObject: tagButton forKey: tagVal];
			[self.view addSubview:tagButton];

		}
	}
};
	 
- (void) tagAction: (id) sender {
	UIButton *resButton = (UIButton *) sender;
	NSLog(@"Pressed tag button %d", resButton.tag);

}
- (void) defineAction: (id) sender {
	UIButton *resButton = (UIButton *) sender;
	NSLog(@"Pressed define button %d", resButton.tag);
	
}

//  Thanks to www.drobnik.com for this trick

- (void) touchDown: (id) sender {
	[self performSelector:@selector(tagAction:) withObject: sender afterDelay: 0.2];
}

- (void) touchDownRepeat: (id) sender {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(tagAction:) object:sender];
	[self defineAction:sender];
}


 // The designated initializer.  Override if you create the controller programmatically and 
 // want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		[self create];
        // Custom initialization
    }
    return self;
}


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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
