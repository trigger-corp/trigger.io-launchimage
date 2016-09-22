//
//  launchimage_Util.m
//  Forge
//
//  Created by Connor Dunn on 06/07/2012.
//  Copyright (c) 2012 Trigger Corp. All rights reserved.
//

#import "launchimage_Util.h"

@implementation launchimage_Util

UIStoryboard *launchScreenStoryBoard;
UIViewController *launchScreenViewController;

+ (void) showLaunchImage {
    launchScreenStoryBoard = [UIStoryboard storyboardWithName:@"Launch Screen Manual" bundle:nil];
    launchScreenViewController = [launchScreenStoryBoard instantiateViewControllerWithIdentifier:@"LaunchScreenManual"];
    [[[ForgeApp sharedApp] viewController] presentViewController:launchScreenViewController animated:NO completion:NULL];
}

+ (void) hideLaunchImage {
    if (launchScreenViewController != nil) {
        [[[ForgeApp sharedApp] viewController] dismissViewControllerAnimated:NO completion:nil];
        launchScreenViewController = nil;
    }
}

// iOS 7 introduced a new app switcher which does not provide aesthetically
// pleasing results and interferes with other modules when we show the
// launchimage on app resume
+ (bool) haveAppLauncher {
	NSString *required = @"7.0";
	NSString *current = [[UIDevice currentDevice] systemVersion];
	return [current compare:required options:NSNumericSearch] != NSOrderedAscending;
}

@end
