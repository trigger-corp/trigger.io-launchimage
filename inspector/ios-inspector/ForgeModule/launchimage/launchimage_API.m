//
//  launchimage_API.m
//  ForgeTemplate
//
//  Created by James Brady on 31/10/2012.
//  Copyright (c) 2012 Trigger Corp. All rights reserved.
//

#import "launchimage_API.h"
#import "launchimage_Util.h"

@implementation launchimage_API

+(void)hide:(ForgeTask*)task {
	[launchimage_Util hideLaunchImage];
	[task success:nil];
}

@end
