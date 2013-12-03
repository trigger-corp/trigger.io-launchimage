//
//  launchimage_EventListener.m
//  Forge
//
//  Created by Connor Dunn on 06/07/2012.
//  Copyright (c) 2012 Trigger Corp. All rights reserved.
//

#import "launchimage_EventListener.h"
#import "launchimage_Util.h"

@implementation launchimage_EventListener

+ (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[launchimage_Util showLaunchImage];
}

+ (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[launchimage_Util updateLaunchImageOrientation:toInterfaceOrientation];
}

+ (void)applicationWillResume:(UIApplication *)application {
	[launchimage_Util hideLaunchImage];
}

+ (void)applicationDidEnterBackground:(UIApplication *)application {
	[launchimage_Util showLaunchImage];
}

+ (void)applicationIsReloading {
	dispatch_async(dispatch_get_main_queue(), ^{
		[launchimage_Util showLaunchImage];
	});
}

@end
