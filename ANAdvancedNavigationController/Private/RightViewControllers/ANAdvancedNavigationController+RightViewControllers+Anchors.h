//
//  ANAdvancedNavigationController+RightViewControllers+Anchors.h
//  iGithub
//
//  Created by Oliver Letterer on 14.07.11.
//  Copyright 2011 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANAdvancedNavigationController.h"

@interface ANAdvancedNavigationController (ANAdvancedNavigationController_RightViewControllers_Anchors)

@property (nonatomic, readonly) CGFloat __minimumDragOffsetToShowRemoveInformation;

// anchor points, at which the viewControllers views center will be layed out
@property (nonatomic, readonly) CGFloat __anchorPortraitLeft;
@property (nonatomic, readonly) CGFloat __anchorPortraitRight;
@property (nonatomic, readonly) CGFloat __anchorLandscapeLeft;
@property (nonatomic, readonly) CGFloat __anchorLandscapeMiddle;
@property (nonatomic, readonly) CGFloat __anchorLandscapeRight;
@property (nonatomic, readonly) CGFloat __leftAnchorForInterfaceOrientation;
@property (nonatomic, readonly) CGFloat __rightAnchorForInterfaceOrientation;
- (CGFloat)__leftAnchorForInterfaceOrientationAndRightViewController:(UIViewController *)rightViewController;

- (CGPoint)__centerPointForRightViewController:(UIViewController *)rightViewController withIndexOfCurrentViewControllerAtRightAnchor:(NSUInteger)indexOfMostRightViewController;

@end
