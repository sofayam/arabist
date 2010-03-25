//
//  asihttpViewController.h
//  asihttp
//
//  Created by mark andrew on 3/11/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface asihttpViewController : UIViewController {
	

	UITextView *ftContent;

}

- (IBAction) pressed: (id) sender;

//@property (nonatomic, retain) IBOutlet UIScrollView *fetchedText;
@property (nonatomic, retain) IBOutlet UITextView *ftContent;

@end

