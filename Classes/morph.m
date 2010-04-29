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

static NSArray *patterns = nil;

enum vtype
{
	sound,
	geminate,
	hamzated1,
	hamzated2,
	hamzated3,
	assimilated,
	hollow,
	defective
};

static NSArray *formISoundNouns = nil;
static NSArray *formIGeminateNouns = nil;
static NSArray *formIHamzated1Nouns = nil;

+ (void) initialize {
	if (!patterns) {
		patterns = 
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
	};
	
	if (!formISoundNouns) { // p466
		formISoundNouns = 
			[[NSArray alloc] initWithObjects:
			 @"1a23",
			 @"1a2a3",
			 @"1u23",
			 @"1i23"
			 @"1a23p",
			 @"1u23p",
			 @"1i23p",
			 @"1u2w3",
			 @"1u2w3p",
			 @"1i2A3",
			 @"1i2A3p",			 
			 @"1a2A3p",				 
			 @"1a23An",				 
			 @"1i23An",				 			 
			 @"ma12i3",
			 @"ma12i3p",
			 nil
			 ];
	}
	if (!formIGeminateNouns) { // p466
		formIGeminateNouns = 
		[[NSArray alloc] initWithObjects:
		 @"1a23",
		 @"1a2a3",
		 @"1a2w3p",
		 @"1a2A3p",
		 @"1i23p",
		 nil
		 ];
	}
	if (!formIHamzated1Nouns) { // p466
		formIHamzated1Nouns = 
		[[NSArray alloc] initWithObjects:
		 @"1a23",
		 @"1a2a3",
		 @"1a2w3p",
		 nil
		 ];
	}
}
	
+ (NSMutableArray*) getMorphs:(NSString*)root  {
	
	NSMutableArray *ret = [[NSMutableArray alloc] init];
	for (int pidx=0; pidx < patterns.count; pidx++) {
		// choose skeleton component
		int rootLength = [root length];
		NSString *scratch = [[NSString alloc] initWithString: [patterns objectAtIndex: pidx]];
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
