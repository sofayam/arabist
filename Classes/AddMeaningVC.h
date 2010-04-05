//
//  AddMeaningVC.h
//  Arabist2
//
//  Created by mark andrew on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddMeaningVC : UIViewController {

	UITextField *contextField;
	UITextField *meaningField;
	NSMutableArray *meaningsModel;
	NSMutableSet *meaningsSet;
	NSManagedObjectContext *context;
	
}

- (IBAction) addMeaning;

@property (nonatomic, retain) IBOutlet UITextField *contextField;
@property (nonatomic, retain) IBOutlet UITextField *meaningField;
@property (nonatomic, retain) NSManagedObjectContext *context;


@property (nonatomic, retain) NSMutableArray *meaningsModel;
@property (nonatomic, retain) NSMutableSet *meaningsSet;

@end
