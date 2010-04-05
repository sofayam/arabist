//
//  buck.h
//  bucktest
//
//  Created by mark andrew on 2/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface buck : NSObject {

}
+ (void) initialize;
+ (NSString*) getArabFromBuck:(NSString*)buckString;
+ (NSString*) getBuckFromArab:(NSString*)arabString;

@end
