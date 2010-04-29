//
//  TagButVC.h
//  Arabist2
//
//  Created by mark andrew on 4/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TagButVC : UIViewController {
	NSMutableDictionary *butDict;
}

- (IBAction) create;

@property (nonatomic, retain) NSMutableDictionary *butDict;


@end
