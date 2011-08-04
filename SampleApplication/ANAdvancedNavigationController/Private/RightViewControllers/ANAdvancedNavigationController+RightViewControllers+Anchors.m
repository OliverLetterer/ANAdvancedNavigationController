//
//  ANAdvancedNavigationController+RightViewControllers+Anchors.m
//  iGithub
//
//  Created by Oliver Letterer on 14.07.11.
//  Copyright 2011 Home. All rights reserved.
//

#import "ANAdvancedNavigationController+RightViewControllers+Anchors.h"
#import "ANAdvancedNavigationController+private.h"

@implementation ANAdvancedNavigationController (ANAdvancedNavigationController_RightViewControllers_Anchors)

- (CGFloat)__minimumDragOffsetToShowRemoveInformation {
    CGRect frame = self.removeRectangleIndicatorView.frame;
    return CGRectGetWidth(frame) + frame.origin.x + ANAdvancedNavigationControllerDefaultViewControllerWidth/2.0f - 20.0f;
}

- (CGFloat)__leftBoundsPanningAnchor {
    // if we only have one viewController, we can pan infinite
    if (self.viewControllers.count <= 1) {
        return -CGFLOAT_MAX;
    }
    return ANAdvancedNavigationControllerDefaultLeftPanningOffset + ANAdvancedNavigationControllerDefaultViewControllerWidth/2.0f;
}

- (CGFloat)__anchorPortraitLeft {
    return ANAdvancedNavigationControllerDefaultLeftPanningOffset + ANAdvancedNavigationControllerDefaultViewControllerWidth/2.0f;
}

- (CGFloat)__anchorPortraitRight {
    return CGRectGetWidth(self.view.bounds) - ANAdvancedNavigationControllerDefaultViewControllerWidth/2.0f;
}

- (CGFloat)__anchorLandscapeLeft {
    return ANAdvancedNavigationControllerDefaultLeftPanningOffset + ANAdvancedNavigationControllerDefaultViewControllerWidth/2.0f;
}

- (CGFloat)__anchorLandscapeMiddle {
    return ANAdvancedNavigationControllerDefaultLeftViewControllerWidth + ANAdvancedNavigationControllerDefaultViewControllerWidth/2.0f;
}

- (CGFloat)__anchorLandscapeRight {
    return CGRectGetWidth(self.view.bounds) - ANAdvancedNavigationControllerDefaultViewControllerWidth/2.0f;
}

- (CGFloat)__leftAnchorForInterfaceOrientation {
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        return self.__anchorPortraitLeft;
    } else {
        return self.__anchorLandscapeLeft;
    }
}

- (CGFloat)__rightAnchorForInterfaceOrientation {
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        return self.__anchorPortraitRight;
    } else {
        return self.__anchorLandscapeRight;
    }
}

- (CGFloat)__leftAnchorForInterfaceOrientationAndRightViewController:(UIViewController *)rightViewController {
    CGFloat anchor = self.__leftAnchorForInterfaceOrientation;
    NSUInteger index = [self.viewControllers indexOfObject:rightViewController];
    return anchor + index*2;
}

- (CGPoint)__centerPointForRightViewController:(UIViewController *)rightViewController 
 withIndexOfCurrentViewControllerAtRightAnchor:(NSUInteger)indexOfMostRightViewController {
    
    if (![self.viewControllers containsObject:rightViewController]) {
        [NSException raise:NSInternalInconsistencyException format:@"rightViewController (%@) is not part of the viewController hierarchy", rightViewController];
    }
    if (indexOfMostRightViewController >= self.viewControllers.count) {
        [NSException raise:NSInternalInconsistencyException format:@"indexOfMostRightViewController (%d) excedes number of ViewControllers (%d)", indexOfMostRightViewController, self.viewControllers.count];
    }
    
    if (self.viewControllers.count <= 1) { // only one view controller
        CGFloat anchorPoint = 0.0;
        // move it to the right or to the middle based on interfaceOrientation
        if (UIDeviceOrientationIsPortrait(self.interfaceOrientation)) {
            anchorPoint = self.__anchorPortraitRight;
        } else {
            anchorPoint = self.__anchorLandscapeMiddle;
        }
        return CGPointMake(anchorPoint, CGRectGetHeight(self.view.bounds)/2.0f);
    }
    
    // now we definetly have more that one viewController in our hierarchy
    NSUInteger indexOfRightViewController = [self.viewControllers indexOfObject:rightViewController];
    
    if (indexOfRightViewController < indexOfMostRightViewController) {
        // the viewController needs to be put on our left stack
        return CGPointMake([self __leftAnchorForInterfaceOrientationAndRightViewController:rightViewController], CGRectGetHeight(self.view.bounds)/2.0f);
    } else if (indexOfRightViewController == indexOfMostRightViewController) {
        // this viewController must be pushed on our right site
        if (indexOfRightViewController == 0) {
            // its the first most down viewController
            CGFloat anchorPoint = 0.0f;
            // portrait -> move to left, landscape -> move to middle
            if (UIDeviceOrientationIsPortrait(self.interfaceOrientation)) {
                anchorPoint = self.__anchorPortraitRight;
            } else {
                anchorPoint = self.__anchorLandscapeMiddle;
            }
            return CGPointMake(anchorPoint, CGRectGetHeight(self.view.bounds)/2.0f);
        } else {
            return CGPointMake(self.__rightAnchorForInterfaceOrientation, CGRectGetHeight(self.view.bounds)/2.0f);
        }
    } else {
        if (UIDeviceOrientationIsLandscape(self.interfaceOrientation) && indexOfMostRightViewController == 0) {
            // our most right one will be in the middle
            CGFloat anchorPoint = self.__anchorLandscapeMiddle + (CGFloat)(indexOfRightViewController - indexOfMostRightViewController) * ANAdvancedNavigationControllerDefaultDraggingDistance;
            
            return CGPointMake(anchorPoint, CGRectGetHeight(self.view.bounds)/2.0f);
        }
        // this viewController is on the right site of our current active viewController
        CGFloat anchorPoint = self.__rightAnchorForInterfaceOrientation + (CGFloat)(indexOfRightViewController - indexOfMostRightViewController) * ANAdvancedNavigationControllerDefaultDraggingDistance;
        
        return CGPointMake(anchorPoint, CGRectGetHeight(self.view.bounds)/2.0f);
    }
}

@end
