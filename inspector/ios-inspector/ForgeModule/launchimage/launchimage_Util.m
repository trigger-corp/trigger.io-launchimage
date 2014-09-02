//
//  launchimage_Util.m
//  Forge
//
//  Created by Connor Dunn on 06/07/2012.
//  Copyright (c) 2012 Trigger Corp. All rights reserved.
//

#import "launchimage_Util.h"

@implementation launchimage_Util

UIImageView *launchImage;

+ (void) updateLaunchImageOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if ([ForgeViewController isIPad]) {
		if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
			if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
				if ([[UIScreen mainScreen] scale] >= 2) {
					launchImage.image = [UIImage imageNamed:@"Default-700-Landscape@2x~ipad.png"];
				} else {
					launchImage.image = [UIImage imageNamed:@"Default-700-Landscape~ipad.png"];
				}
				launchImage.frame = CGRectMake(0.0f, 0.0f, 1024.0f, 768.0f);
			} else if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
				if ([[UIScreen mainScreen] scale] >= 2) {
					launchImage.image = [UIImage imageNamed:@"Default-700-Portrait@2x~ipad.png"];
				} else {
					launchImage.image = [UIImage imageNamed:@"Default-700-Portrait~ipad.png"];
				}
				launchImage.frame = CGRectMake(0.0f, 0.0f, 768.0f, 1024.0f);
			}
		} else {
			if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
				if ([[UIScreen mainScreen] scale] >= 2) {
					launchImage.image = [UIImage imageNamed:@"Default-Landscape@2x~ipad.png"];
				} else {
					launchImage.image = [UIImage imageNamed:@"Default-Landscape~ipad.png"];
				}
				if ([UIApplication sharedApplication].statusBarHidden) {
					launchImage.frame = CGRectMake(0.0f, 0.0f, 1051.0f, 768.0f);
				} else {
					launchImage.frame = CGRectMake(0.0f, 0.0f, 1024.0f, 748.0f);
				}
			} else if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
				if ([[UIScreen mainScreen] scale] >= 2) {
					launchImage.image = [UIImage imageNamed:@"Default-Portrait@2x~ipad.png"];
				} else {
					launchImage.image = [UIImage imageNamed:@"Default-Portrait~ipad.png"];
				}
				if ([UIApplication sharedApplication].statusBarHidden) {
					launchImage.frame = CGRectMake(0.0f, 0.0f, 783.0f, 1024.0f);
				} else {
					launchImage.frame = CGRectMake(0.0f, 0.0f, 768.0f, 1004.0f);
				}
			}
		}
	} else {
		float width = 320.0f;
		float height = 480.0f;
		float x = 0.0f;
		float y = 0.0f;
		if ([[UIScreen mainScreen] scale] >= 2) {
			if ([[UIScreen mainScreen] bounds].size.height == 568) {
				launchImage.image = [UIImage imageNamed:@"Default-568h@2x~iphone.png"];
				height = 568.0f;
			} else {
				launchImage.image = [UIImage imageNamed:@"Default@2x~iphone.png"];
			}
		} else {
			launchImage.image = [UIImage imageNamed:@"Default~iphone.png"];
		}
		if (![UIApplication sharedApplication].statusBarHidden && floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
			y = -20.0f;
		}
		
		launchImage.frame = CGRectMake(x, y, width, height);
	}
}

+ (void) showLaunchImage {
	if (launchImage == nil) {
		launchImage = [[UIImageView alloc] init];
		[[[ForgeApp sharedApp] viewController].view addSubview:launchImage];
	}
	
	[self updateLaunchImageOrientation:[[ForgeApp sharedApp] viewController].interfaceOrientation];

	// Force portrait only when launch image is shown on iOS.
	if (![ForgeViewController isIPad]) {
		[[ForgeApp sharedApp] viewController]->forcePortrait = YES;
	}

	// Make sure we are at the correct orientation
	// Hack to work around setOrientation being a private method
	dispatch_async(dispatch_get_main_queue(), ^{
		UIViewController *c = [[UIViewController alloc] init];
		
		[[[ForgeApp sharedApp] viewController] presentModalViewController:c animated:NO];
		[[[ForgeApp sharedApp] viewController] dismissModalViewControllerAnimated:NO];
	});
	
	[launchImage setHidden:NO];
}

+ (void) hideLaunchImage {
	[launchImage setHidden:YES];
	
	[[ForgeApp sharedApp] viewController]->forcePortrait = NO;
	
	// Make sure we are at the correct orientation
	// Hack to work around setOrientation being a private method
	dispatch_async(dispatch_get_main_queue(), ^{
		if ([[ForgeApp sharedApp] viewController].modalViewController == nil) {
			UIViewController *c = [[UIViewController alloc] init];
		
			[[[ForgeApp sharedApp] viewController] presentModalViewController:c animated:NO];
			[[[ForgeApp sharedApp] viewController] dismissModalViewControllerAnimated:NO];
		}
	});
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
