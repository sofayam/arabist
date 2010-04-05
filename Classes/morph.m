//
//  morph.m
//  morph
//
//  Created by mark andrew on 2/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "morph.h"
#import "buck.h"


@implementation morph

static NSArray *skels = nil;

+ (void) initialize {
	if (!skels) {
		skels = 
		[[NSArray alloc] initWithObjects:
		 @"1a2a3a",              //I
		 @"1a2~a3a",             //II
		 @"1A2a3a",              //III
		 @"A1o2a3a",             //IV
		 @"ta1a2~a3a",           //V
		 @"ta1A2a3a",            //VI
		 @"<no1a2a3a",           //VII
		 @"<1ota2a3a",           //VIII
		 @"<1a2~a3a",            //IX
		 @"<sta1o2a3a",          //X
		 nil
		 ];
	}
}
+ (NSMutableArray*) getMorphs:(NSString*)root  {
	NSMutableArray *ret = [[NSMutableArray alloc] init];
	int skelLength = skels.count;
	for (int ski=0; ski < skelLength; ski++) {
		// choose skeleton component
		int rootLength = [root length];
		NSString *scratch = [[NSString alloc] initWithString: [skels objectAtIndex: ski]];
		 for (int roi=0; roi < rootLength; roi++) {
			 //replace index in skel with number
			 NSString *placeHolder = [NSString stringWithFormat: @"%i", roi+1];
			 NSString *rootchar = 
				[NSString stringWithFormat: @"%C", [root characterAtIndex: roi]];
			 scratch = [scratch stringByReplacingOccurrencesOfString: 
							 placeHolder withString: rootchar];
		 }
		[ret addObject: [buck getArabFromBuck: scratch]];
	}
	return ret;
}



@end
