//
//  ANAdvancedNavigationController.m
//  ANAdvancedNavigationController
//
//  Created by Oliver Letterer on 28.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ANAdvancedNavigationController.h"
#import "ANAdvancedNavigationController+private.h"
#import "ANAdvancedNavigationController+LeftViewController.h"
#import "ANAdvancedNavigationController+RightViewControllers.h"
#import <QuartzCore/QuartzCore.h>

const CGFloat ANAdvancedNavigationControllerDefaultLeftViewControllerWidth  = 291.0f;
const CGFloat ANAdvancedNavigationControllerDefaultViewControllerWidth      = 475.0f;
const CGFloat ANAdvancedNavigationControllerDefaultLeftPanningOffset        = 75.0f;

const CGFloat ANAdvancedNavigationControllerDefaultAnimationDuration        = 0.35f;
const CGFloat ANAdvancedNavigationControllerDefaultDraggingDistance         = 473.0f;// = ANAdvancedNavigationControllerDefaultViewControllerWidth - 2.0f

@implementation ANAdvancedNavigationController

@synthesize backgroundView=_backgroundView;
@synthesize leftViewController=_leftViewController, viewControllers=_viewControllers, removeRectangleIndicatorView=_removeRectangleIndicatorView;
@synthesize delegate=_delegate;
@synthesize draggingStartDate=_draggingStartDate;

#pragma mark - setters and getters

- (void)setLeftViewController:(UIViewController *)leftViewController {
    if (_leftViewController != leftViewController) {
        [self _setLeftViewController:leftViewController];
    }
}

- (void)setBackgroundView:(UIView *)backgroundView {
    if (backgroundView != _backgroundView) {
        [_backgroundView removeFromSuperview];
        _backgroundView = backgroundView;
        [self updateBackgroundView];
    }
}

- (NSArray *)rightViewControllers {
    return [_viewControllers copy];
}

- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers {
    return NO;
}

- (NSUInteger)indexOfFrontViewController {
    return _indexOfFrontViewController;
}

- (void)setIndexOfFrontViewController:(NSUInteger)indexOfFrontViewController {
    [self _setIndexOfFrontViewController:indexOfFrontViewController];
}

#pragma mark - initialization

- (id)init {
    if ((self = [super init])) {
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
            [NSException raise:NSInternalInconsistencyException format:@"ANAdvancedNavigationController is only supposed to work on iPad"];
        }
        self.viewControllers = [NSMutableArray array];
    }
    return self;
}

- (id)initWithLeftViewController:(UIViewController *)leftViewController {
    if ((self = [self init])) {
        self.leftViewController = leftViewController;
    }
    return self;
}

- (id)initWithLeftViewController:(UIViewController *)leftViewController rightViewControllers:(NSArray *)rightViewControllers {
    if (self = [self initWithLeftViewController:leftViewController]) {
        [rightViewControllers enumerateObjectsUsingBlock:^(__strong id obj, NSUInteger idx, BOOL *stop) {
            [self _insertRightViewControllerInDataModel:obj];
        }];
    }
    return self;
}

#pragma mark - Pushing and Poping

- (void)popViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (![self.viewControllers containsObject:viewController]) {
        [NSException raise:NSInternalInconsistencyException format:@"viewController (%@) is not part of the viewController Hierarchy", viewController];
    }
    
    NSInteger index = [self.viewControllers indexOfObject:viewController]-1;
    
    if (index >= 0) {
        viewController = [self.viewControllers objectAtIndex:index];
        [self _popViewControllersToViewController:viewController animated:animated];
    }
}

- (void)popViewControllersToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self _popViewControllersToViewController:viewController animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController afterViewController:(UIViewController *)afterViewController animated:(BOOL)animated {
    [self _pushViewController:viewController afterViewController:afterViewController animated:animated];
}

#pragma mark - View lifecycle

- (void)loadView {
    [super loadView];
    
    CGFloat removeHeight = 75.0f;
    self.removeRectangleIndicatorView = [[ANRemoveRectangleIndicatorView alloc] initWithFrame:CGRectMake(ANAdvancedNavigationControllerDefaultLeftViewControllerWidth + 5.0f, CGRectGetHeight(self.view.bounds)/2.0f-removeHeight, 175.0f, removeHeight*2.0f)];
    self.removeRectangleIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view insertSubview:self.removeRectangleIndicatorView atIndex:0];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    [self updateBackgroundView];
    [self _insertLeftViewControllerView];
    [self _prepareViewForPanning];
    [self _insertRightViewControllerViews];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    _removeRectangleIndicatorView = nil;
    _draggingStartDate = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    for (UIViewController *viewController in self.childViewControllers) {
        if (![viewController shouldAutorotateToInterfaceOrientation:interfaceOrientation]) {
            return NO;
        }
    }
	return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self _willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    for (UIViewController *viewController in self.childViewControllers) {
        [viewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    for (UIViewController *viewController in self.childViewControllers) {
        [viewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    }
}

#pragma mark - private implementation

- (void)updateBackgroundView {
    if (self.isViewLoaded) {
        _backgroundView.frame = self.view.bounds;
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view insertSubview:_backgroundView atIndex:0];
    }
}

@end






@implementation UIViewController (ANAdvancedNavigationController)

- (ANAdvancedNavigationController *)advancedNavigationController {
    UIViewController *viewController = self.parentViewController;
    while (viewController != nil) {
        if ([viewController isKindOfClass:[ANAdvancedNavigationController class] ]) {
            return (ANAdvancedNavigationController *)viewController;
        } else {
            viewController = viewController.parentViewController;
        }
    }
    return nil;
}

@end
