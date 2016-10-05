//
//  launchimage_Util.h
//  Forge
//
//  Created by Connor Dunn on 06/07/2012.
//  Copyright (c) 2012 Trigger Corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface launchimage_Util : NSObject

+ (void) initializeLaunchImage;
+ (void) showLaunchImage;
+ (void) hideLaunchImage;
+ (bool) haveAppLauncher;

@end
