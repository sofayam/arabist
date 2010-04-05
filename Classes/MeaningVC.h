//
//  MeaningVC.h
//  Arabist2
//
//  Created by mark andrew on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MeaningVC : UITableViewController {
	
	NSMutableArray *meaningsModel;
	NSMutableSet *meaningsSet;
	NSManagedObjectContext *context;
}

@property (nonatomic, retain) NSMutableArray *meaningsModel;
@property (nonatomic, retain) NSMutableSet *meaningsSet;
@property (nonatomic, retain) NSManagedObjectContext *context;

@end
