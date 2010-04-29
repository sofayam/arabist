//
//  MorphVC.h
//  Arabist2
//
//  Created by mark andrew on 4/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MorphVCDelegate;

@interface MorphVC : UITableViewController {
	
	NSString *root;
	NSMutableArray *morphs;
	id <MorphVCDelegate> delegate;

}

@property (nonatomic, retain) NSString *root;
@property (nonatomic, retain) NSMutableArray *morphs;

@property (nonatomic, retain) id <MorphVCDelegate> delegate;

@end

@protocol MorphVCDelegate

- (void) setWord: (NSString *) word;

@end

