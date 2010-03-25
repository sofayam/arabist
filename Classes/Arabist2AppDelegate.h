//
//  Arabist2AppDelegate.h
//  Arabist2
//
//  Created by mark andrew on 3/6/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTableViewController.h"
#import "FilterViewController.h"
#import "AddViewController.h"
#import "asihttpViewController.h"

@interface Arabist2AppDelegate : NSObject <UIApplicationDelegate> {
	
	NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	
		
    UIWindow *window;
    UITabBarController *tabBarController;
    MyTableViewController *myTableViewController;
    FilterViewController *myFilterViewController;
    AddViewController *myAddViewController;	
	asihttpViewController *myASIHTTPViewController;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) MyTableViewController *myTableViewController;
@property (nonatomic, retain) FilterViewController *myFilterViewController;
@property (nonatomic, retain) AddViewController *myAddViewController;
@property (nonatomic, retain) asihttpViewController *myASIHTTPViewController;


@end

