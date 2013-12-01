//
//  AppDelegate.m
//  Brews
//
//  Created by Bradley Bergeron on 30/11/13.
//  Copyright (c) 2013 Bradley Bergeron. All rights reserved.
//

#import "AppDelegate.h"
#import "BRDefines.h"
#import "BreweryDB.h"


#pragma mark -
@implementation AppDelegate

static AppDelegate *_sharedDelegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        _sharedDelegate = self;
    }
    return self;
}

+ (instancetype)sharedDelegate
{
    return _sharedDelegate;
}

#pragma mark Application Lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [BreweryDB brew:BREWERYDB_API_KEY];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
