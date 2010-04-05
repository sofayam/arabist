//
//  Entry.h
//  Arabist2
//
//  Created by mark andrew on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Entry :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * root;
@property (nonatomic, retain) NSString * morph;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * word;
@property (nonatomic, retain) NSSet* idioms;
@property (nonatomic, retain) NSSet* examples;
@property (nonatomic, retain) NSSet* meanings;
@property (nonatomic, retain) NSSet* tags;

@end


@interface Entry (CoreDataGeneratedAccessors)
- (void)addIdiomsObject:(NSManagedObject *)value;
- (void)removeIdiomsObject:(NSManagedObject *)value;
- (void)addIdioms:(NSSet *)value;
- (void)removeIdioms:(NSSet *)value;

- (void)addExamplesObject:(NSManagedObject *)value;
- (void)removeExamplesObject:(NSManagedObject *)value;
- (void)addExamples:(NSSet *)value;
- (void)removeExamples:(NSSet *)value;

- (void)addMeaningsObject:(NSManagedObject *)value;
- (void)removeMeaningsObject:(NSManagedObject *)value;
- (void)addMeanings:(NSSet *)value;
- (void)removeMeanings:(NSSet *)value;

- (void)addTagsObject:(NSManagedObject *)value;
- (void)removeTagsObject:(NSManagedObject *)value;
- (void)addTags:(NSSet *)value;
- (void)removeTags:(NSSet *)value;

@end

