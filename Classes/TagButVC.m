//
//  TagButVC.m
//  Arabist2
//
//  Created by mark andrew on 4/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TagButVC.h"


@implementation TagButVC
@synthesize butDict, delegate;

UIAlertView *tagAlert;
UITextField *tagTextField;
UIButton *currentButton;

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

		}
	}
};
	 
- (void) tagAction: (id) sender {
	UIButton *resButton = (UIButton *) sender;
	NSLog(@"Pressed tag button %d", resButton.tag);
	[delegate addTag:resButton.currentTitle];

}
/*
- (void) presentSheet //TODO This is undocumented SDKafvfv
{
	UIAlertView *alert = [[UIAlertView alloc] 
						  initWithTitle: @"Enter Information" 
						  message:@"Specify the Name and URL"
						  delegate:self
						  cancelButtonTitle:@"Cancel"
						  otherButtonTitles:@"OK", nil];
	[alert addTextFieldWithValue:@"" label:@"Enter Name"];
	[alert addTextFieldWithValue:@"http://" label:@"Enter URL"];
	
	// Name field
	UITextField *tf = [alert textFieldAtIndex:0];
	tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.keyboardType = UIKeyboardTypeAlphabet;
	tf.keyboardAppearance = UIKeyboardAppearanceAlert;
	tf.autocapitalizationType = UITextAutocapitalizationTypeWords;
	tf.autocorrectionType = UITextAutocorrectionTypeNo;
	
	// URL field
	tf = [alert textFieldAtIndex:1];
	tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.keyboardType = UIKeyboardTypeURL;
	tf.keyboardAppearance = UIKeyboardAppearanceAlert;
	tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
	tf.autocorrectionType = UITextAutocorrectionTypeNo;
	
	[alert show];
}

*/

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
	//[tagAlert release];

	
} 

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSLog(@"User Pressed Button %d with input %@\n", buttonIndex + 1, tagTextField.text);
	if (buttonIndex == 1) 
		[currentButton setTitle:tagTextField.text forState:UIControlStateNormal];
	[tagTextField removeFromSuperview];
	[tagTextField release];
	[tagAlert release];
	
	//printf("User Pressed Button %d\n", buttonIndex + 1);
	//printf("Text Field 1: %s\n", [[[alertView textFieldAtIndex:0] text] cStringUsingEncoding:1]);
	//printf("Text Field 2: %s\n", [[[alertView textFieldAtIndex:1] text] cStringUsingEncoding:1]);	
	//[alertView release];
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
