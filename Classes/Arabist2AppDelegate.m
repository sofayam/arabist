//
//  Arabist2AppDelegate.m
//  Arabist2
//
//  Created by mark andrew on 3/6/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Arabist2AppDelegate.h"


@implementation Arabist2AppDelegate

@synthesize window, myFilterViewController, myTableViewController, 
			myAddViewController,  tabBarController, myASIHTTPViewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	tabBarController = [[UITabBarController alloc] init];          
	// creates your tab bar so you can add everything else to it
	
	myTableViewController = [[MyTableViewController alloc] init]; 
	
	// creates your table view - this should be a UIViewController with a table view in it, or UITableViewController
	UINavigationController *tableNavController = [[[UINavigationController alloc] initWithRootViewController:myTableViewController] autorelease];
	tableNavController.tabBarItem = [ [ UITabBarItem alloc ] initWithTitle: @"List" image: nil tag: 2];

	
	// Core Data Magic
	myTableViewController.managedObjectContext = self.managedObjectContext;
	
	
	[myTableViewController release];                                                              
	// creates your table view's navigation controller, then adds the view controller you made. 
	//Note I then let go of the view controller as the navigation controller now holds onto it for me. This saves memory.
	
	
	myFilterViewController = [[FilterViewController alloc] init];  
	myAddViewController = [[AddViewController alloc] init];  
	myASIHTTPViewController = [[asihttpViewController alloc] init];
	tabBarController.viewControllers = [NSArray arrayWithObjects:
										tableNavController,
										myAddViewController,
										myFilterViewController, 
										myASIHTTPViewController,
										nil]; 
	/* add both of your navigation controllers to the tab bar. You can put as many controllers 
	 on as you like, but they will turn into the more button like in the iPod program. */

	
	[window addSubview:tabBarController.view];        // adds the tab bar's view property to the window
	[window makeKeyAndVisible];                       // makes the window visible
	
	
	UIDevice *myDevice = [UIDevice currentDevice];
	NSString *deviceUDID = [myDevice uniqueIdentifier];
	NSLog(@"Device ID %@", deviceUDID);
}

/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }
}

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	NSString *addir = [self applicationDocumentsDirectory] ;
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [addir stringByAppendingPathComponent: @"arabist2.sqlite"]];
	
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
							 
							 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
							 
							 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];

	
	
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil 
															URL:storeUrl options:options error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return persistentStoreCoordinator;
}

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}




- (void)dealloc {
		
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
	
	[tabBarController release];
	[window release];
	[super dealloc];
}                                           // lets go of everything else, thats so your program doesn't create any leaks of memory.

@end