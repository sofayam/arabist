//
//  Tag.h
//  Arabist2
//
//  Created by mark andrew on 5/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Entry;

@interface Tag :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * button;
@property (nonatomic, retain) NSSet* tagged;

@end


@interface Tag (CoreDataGeneratedAccessors)
- (void)addTaggedObject:(Entry *)value;
- (void)removeTaggedObject:(Entry *)value;
- (void)addTagged:(NSSet *)value;
- (void)removeTagged:(NSSet *)value;

@end

