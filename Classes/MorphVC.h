//
//  MorphVC.h
//  Arabist2
//
//  Created by mark andrew on 4/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MorphVC : UITableViewController {
	
	NSString *root;
	NSMutableArray *morphs;

}

@property (nonatomic, retain) NSString *root;
@property (nonatomic, retain) NSMutableArray *morphs;

@end
