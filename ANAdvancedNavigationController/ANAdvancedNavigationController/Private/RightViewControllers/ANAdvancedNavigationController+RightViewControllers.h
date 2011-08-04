//
//  ANAdvancedNavigationController+RightViewControllers.h
//  iGithub
//
//  Created by Oliver Letterer on 14.07.11.
//  Copyright 2011 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANAdvancedNavigationController.h"

@interface ANAdvancedNavigationController (ANAdvancedNavigationController_RightViewControllers)

- (void)_pushViewController:(UIViewController *)viewController 
        afterViewController:(UIViewController *)afterViewController animated:(BOOL)animated;

- (void)_popViewControllersToViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)_prepareViewForPanning;

- (void)_willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;

- (void)_insertRightViewControllerInDataModel:(UIViewController *)rightViewController;
- (void)_insertRightViewControllerViews;

- (void)_setIndexOfFrontViewController:(NSUInteger)indexOfFrontViewController;

@end
