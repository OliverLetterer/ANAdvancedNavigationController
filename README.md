# ANAdvancedNavigationController

**ANAdvancedNavigationController** is a subclass of *UIViewController* and works as a parent view controller.

## Setup ANAdvancedNavigationController for your project

* link against <**QuartzCore.framework**>
* add the *ANAdvancedNavigationController* folder to your project

## How to use ANAdvancedNavigationController

### Setup an instance of ANAdvancedNavigationController

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // create your viewControllers that are displayed
    UIViewController *leftViewController = ...;
    // create an instance of ANAdvancedNavigationController
    ANAdvancedNavigationController *navigationController = [[ANAdvancedNavigationController alloc] initWithLeftViewController:leftViewController];
    
    // set your instance of ANAdvancedNavigationController as your applicationDelegates self.window.rootViewController
    self.window.rootViewController = navigationController;
    
    // do some more setup
    ....

    [self.window makeKeyAndVisible];
    return YES;
}
```

## Screenshots
