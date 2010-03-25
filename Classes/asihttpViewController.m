//
//  asihttpViewController.m
//  asihttp
//
//  Created by mark andrew on 3/11/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "asihttpViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation asihttpViewController

@synthesize ftContent;

- (IBAction) pressed: (id) sender {

//	fetchedText.text = @"here's some text";
	
	//NSURL *url = [NSURL URLWithString:@"http://192.168.0.7:8081/sign"];
	NSURL *url = [NSURL URLWithString:@"http://arabvocab.appspot.com/sign"];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//	[request setPostValue:@"Ben" forKey:@"first_name"];

	[request setPostValue:@"foo1" forKey:@"meaning" ];
	[request setPostValue:@"bar1" forKey:@"arabtext" ];
	[request setPostValue:@"baz1" forKey:@"romantext" ];
	[request setPostValue:@"rrt1" forKey:@"root" ];
	[request setPostValue:@"example from iphone" forKey:@"usageexample" ];
//		[request setPostValue:@"" forKey:@"" ];
	[request startSynchronous];
	NSError *error = [request error];
	if (!error) {
		NSString *response = [request responseString];
		ftContent.text = response;
	
	}
	
	
}




// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
         self.tabBarItem = [ [ UITabBarItem alloc ] initWithTitle: @"Sync" image: nil tag: 3];
        // Custom initialization
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//fetchedText.contentSize = self.view.frame.size;
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
    [super dealloc];
	//[fetchedText release];
	[ftContent release];
}

@end
