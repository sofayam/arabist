//
//  buck.m
//  bucktest
//
//  Created by mark andrew on 2/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//



/*
    replace < with I (for hamza-under-alif)
    replace > with O (for hamza-over-alif—the A is already used for bare alif)
    replace & with W (for hamza-on-waw)
*/

#import "buck.h"


@implementation buck

static NSMutableDictionary *badict = nil;

static NSMutableDictionary *abdict = nil;

+ (void) initialize {
	if (!abdict) { // they say initialize can be called more than once (?)
	  abdict = 
		[[NSDictionary alloc] initWithObjectsAndKeys:
					  @"$", [NSString stringWithFormat:@"%C", 0x634],
					  @"&", [NSString stringWithFormat:@"%C", 0x624],
					  @"*", [NSString stringWithFormat:@"%C", 0x630],
					  @"<", [NSString stringWithFormat:@"%C", 0x625],
					  @">", [NSString stringWithFormat:@"%C", 0x623],
					  @"D", [NSString stringWithFormat:@"%C", 0x636],
					  @"F", [NSString stringWithFormat:@"%C", 0x64b],
					  @"H", [NSString stringWithFormat:@"%C", 0x62d],
					  @"N", [NSString stringWithFormat:@"%C", 0x64c],
					  @"T", [NSString stringWithFormat:@"%C", 0x637],
					  @"Z", [NSString stringWithFormat:@"%C", 0x638],
					  @"`", [NSString stringWithFormat:@"%C", 0x670],
					  @"b", [NSString stringWithFormat:@"%C", 0x628],
					  @"d", [NSString stringWithFormat:@"%C", 0x62f],
					  @"f", [NSString stringWithFormat:@"%C", 0x641],
					  @"h", [NSString stringWithFormat:@"%C", 0x647],
					  @"j", [NSString stringWithFormat:@"%C", 0x62c],
					  @"l", [NSString stringWithFormat:@"%C", 0x644],
					  @"n", [NSString stringWithFormat:@"%C", 0x646],
					  @"p", [NSString stringWithFormat:@"%C", 0x629],
					  @"r", [NSString stringWithFormat:@"%C", 0x631],
					  @"t", [NSString stringWithFormat:@"%C", 0x62a],
					  @"v", [NSString stringWithFormat:@"%C", 0x62b],
					  @"x", [NSString stringWithFormat:@"%C", 0x62e],
					  @"z", [NSString stringWithFormat:@"%C", 0x632],
					  @"|", [NSString stringWithFormat:@"%C", 0x622],
					  @"~", [NSString stringWithFormat:@"%C", 0x651],
					  @"'", [NSString stringWithFormat:@"%C", 0x621],
					  @"A", [NSString stringWithFormat:@"%C", 0x627],
					  @"E", [NSString stringWithFormat:@"%C", 0x639],
					  @"K", [NSString stringWithFormat:@"%C", 0x64d],
					  @"S", [NSString stringWithFormat:@"%C", 0x635],
					  @"Y", [NSString stringWithFormat:@"%C", 0x649],
					  @"_", [NSString stringWithFormat:@"%C", 0x640],
					  @"a", [NSString stringWithFormat:@"%C", 0x64e],
					  @"g", [NSString stringWithFormat:@"%C", 0x63a],
					  @"i", [NSString stringWithFormat:@"%C", 0x650],
					  @"k", [NSString stringWithFormat:@"%C", 0x643],
					  @"m", [NSString stringWithFormat:@"%C", 0x645],
					  @"o", [NSString stringWithFormat:@"%C", 0x652],
					  @"q", [NSString stringWithFormat:@"%C", 0x642],
					  @"s", [NSString stringWithFormat:@"%C", 0x633],
					  @"u", [NSString stringWithFormat:@"%C", 0x64f],
					  @"w", [NSString stringWithFormat:@"%C", 0x648],
					  @"y", [NSString stringWithFormat:@"%C", 0x64a],
					  @"{", [NSString stringWithFormat:@"%C", 0x671],
					  @"}", [NSString stringWithFormat:@"%C", 0x626],
					  nil];

	badict = [[NSMutableDictionary alloc] init];
	NSEnumerator *myEnum = [abdict keyEnumerator];
	NSString *aKey;
	while (aKey = [myEnum nextObject]) {
		NSObject *aVal = [abdict objectForKey: aKey];
		[badict setObject: aKey forKey: aVal];
		//NSLog(@"akey %@", aKey);
		//NSLog(@"anObject %@", aVal);
		
	}
		NSLog(@"Called initialize");	
  }
}

+ (NSString*) getArabFromBuck:(NSString*)buckString {
	NSString *res = @"";
	NSUInteger strLength = [buckString length];
	for (int i = 0; i < strLength; i++) {
		NSString *ch = [NSString stringWithFormat: @"%C", [buckString characterAtIndex: i]] ;
		NSString *lookup = [badict objectForKey: ch];
		if (!lookup) lookup = ch;
		res = [res stringByAppendingString: lookup];
		//NSLog(buckString);
		//NSLog(res);
	}
  return res;
};

+ (NSString*) getBuckFromArab:(NSString*)arabString {
	NSString *res = @"";
	NSUInteger strLength = [arabString length];
	for (int i = 0; i < strLength; i++) {
		NSString *ch = [NSString stringWithFormat: @"%C", [arabString characterAtIndex: i]] ;
		NSString *lookup = [abdict objectForKey: ch];
		if (!lookup) lookup = ch;
		res = [res stringByAppendingString: lookup];
		//NSLog(buckString);
		//NSLog(res);
	}
	return res;
	
};

@end
