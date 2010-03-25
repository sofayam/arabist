//
//  ExistingWordViewController.h
//  Arabist2
//
//  Created by mark andrew on 3/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ExistingWordViewController : UIViewController {
	
	IBOutlet UITextField *f1;
	IBOutlet UITextField *f2;
	IBOutlet UIScrollView *scr;

	BOOL keyboardVisible;
}


- (void)keyboardDidShow: (NSNotification *) notif;
- (void)keyboardDidHide: (NSNotification *) notif;


@property (nonatomic, retain) UITextField *f1;
@property (nonatomic, retain) UITextField *f2;
@property (nonatomic, retain) UIScrollView *scr;


@end
