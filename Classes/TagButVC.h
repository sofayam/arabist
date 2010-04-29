//
//  TagButVC.h
//  Arabist2
//
//  Created by mark andrew on 4/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TagButVCDelegate;


@interface TagButVC : UIViewController <UIAlertViewDelegate> {
	NSMutableDictionary *butDict;
	id <TagButVCDelegate> delegate;
}

- (IBAction) create;

@property (nonatomic, retain) NSMutableDictionary *butDict;
@property (nonatomic, retain) id <TagButVCDelegate> delegate;


@end

@protocol TagButVCDelegate

- (void) addTag: (NSString *) tag;

@end

