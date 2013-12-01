//
//  AppDelegate.h
//  Brews
//
//  Created by Bradley Bergeron on 30/11/13.
//  Copyright (c) 2013 Bradley Bergeron. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark -
@interface AppDelegate : UIResponder
<UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

+ (instancetype)sharedDelegate;

@end
