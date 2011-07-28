//
//  SampleApplicationAppDelegate.m
//  SampleApplication
//
//  Created by Oliver Letterer on 28.07.11.
//  Copyright 2011 Home. All rights reserved.
//

#import "SampleApplicationAppDelegate.h"
#import "ANAdvancedNavigationController.h"
#import "LeftViewController.h"

@implementation SampleApplicationAppDelegate
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    LeftViewController *leftViewController = [[LeftViewController alloc] initWithStyle:UITableViewStyleGrouped];
    ANAdvancedNavigationController *navigationController = [[ANAdvancedNavigationController alloc] initWithLeftViewController:leftViewController];
    
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
