//
//  launchimage_EventListener.m
//  Forge
//
//  Created by Connor Dunn on 06/07/2012.
//  Copyright (c) 2012 Trigger Corp. All rights reserved.
//

#import "launchimage_EventListener.h"
#import "launchimage_Util.h"

bool initialStartup = true;

@implementation launchimage_EventListener

+ (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    initialStartup = true;
    [launchimage_Util initializeLaunchImage];
}

+ (void)applicationDidBecomeActive:(UIApplication *)application {
    if (initialStartup) {
        [launchimage_Util showLaunchImage];
    }
    initialStartup = false;
}

+ (void)applicationIsReloading {
	dispatch_async(dispatch_get_main_queue(), ^{
		[launchimage_Util showLaunchImage];
	});
}

@end
