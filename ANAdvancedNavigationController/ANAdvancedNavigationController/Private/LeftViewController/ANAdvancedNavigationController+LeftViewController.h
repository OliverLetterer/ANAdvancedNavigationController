//
//  ANAdvancedNavigationController+LeftViewController.h
//  ANAdvancedNavigationController
//
//  Created by Oliver Letterer on 28.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANAdvancedNavigationController.h"

@interface ANAdvancedNavigationController (ANAdvancedNavigationController_LeftViewController)

- (void)_setLeftViewController:(UIViewController *)leftViewController;
- (void)_insertLeftViewControllerView;

@end
