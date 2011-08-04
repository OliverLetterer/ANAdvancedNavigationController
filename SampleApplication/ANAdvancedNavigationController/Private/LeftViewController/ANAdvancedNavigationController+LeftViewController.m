//
//  ANAdvancedNavigationController+LeftViewController.m
//  ANAdvancedNavigationController
//
//  Created by Oliver Letterer on 28.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ANAdvancedNavigationController+LeftViewController.h"
#import "ANAdvancedNavigationController+private.h"

@interface ANAdvancedNavigationController (ANAdvancedNavigationController_LeftViewControllerPrivate)
- (void)__removeLeftViewControllerView;
- (void)__removeLeftViewController;
@end

@implementation ANAdvancedNavigationController (ANAdvancedNavigationController_LeftViewControllerPrivate)

- (void)__removeLeftViewControllerView {
    if (self.isViewLoaded) {
        [_leftViewController viewWillDisappear:NO];
        [_leftViewController.view removeFromSuperview];
        [_leftViewController viewDidDisappear:NO];
    }
}

- (void)__removeLeftViewController {
    [_leftViewController willMoveToParentViewController:nil];
    if (self.isViewLoaded) {
        [self __removeLeftViewControllerView];
    }
    [_leftViewController removeFromParentViewController];
    _leftViewController = nil;
}

@end

@implementation ANAdvancedNavigationController (ANAdvancedNavigationController_LeftViewController)

- (void)_setLeftViewController:(UIViewController *)leftViewController {
    [self __removeLeftViewController];
    
    if (leftViewController != nil) {
        _leftViewController = leftViewController;
        [self addChildViewController:leftViewController];
        if (self.isViewLoaded) {
            [self _insertLeftViewControllerView];
        }
        [_leftViewController didMoveToParentViewController:self];
    }
}

- (void)_insertLeftViewControllerView {
    if (self.isViewLoaded) {
        _leftViewController.view.frame = CGRectMake(0.0f, 0.0f, ANAdvancedNavigationControllerDefaultLeftViewControllerWidth, CGRectGetHeight(self.view.bounds));
        _leftViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [_leftViewController viewWillAppear:NO];
        [self.view addSubview:_leftViewController.view];
        [_leftViewController viewDidAppear:NO];
    }
}

@end
