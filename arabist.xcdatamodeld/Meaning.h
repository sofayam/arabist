//
//  Meaning.h
//  Arabist2
//
//  Created by mark andrew on 4/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Entry;

@interface Meaning :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * meaning;
@property (nonatomic, retain) NSString * context;
@property (nonatomic, retain) Entry * entry;

@end



