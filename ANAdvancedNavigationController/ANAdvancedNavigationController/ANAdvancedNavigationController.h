//
//  ANAdvancedNavigationController.h
//  ANAdvancedNavigationController
//
//  Created by Oliver Letterer on 28.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat ANAdvancedNavigationControllerDefaultLeftViewControllerWidth;
extern const CGFloat ANAdvancedNavigationControllerDefaultViewControllerWidth;
extern const CGFloat ANAdvancedNavigationControllerDefaultLeftPanningOffset;

@class ANAdvancedNavigationController;



@protocol ANAdvancedNavigationControllerDelegate <NSObject>

@optional
- (void)advancedNavigationController:(ANAdvancedNavigationController *)navigationController willPushViewController:(UIViewController *)viewController afterViewController:(UIViewController *)afterViewController animated:(BOOL)animated;
- (void)advancedNavigationController:(ANAdvancedNavigationController *)navigationController didPushViewController:(UIViewController *)viewController afterViewController:(UIViewController *)afterViewController animated:(BOOL)animated;

- (void)advancedNavigationController:(ANAdvancedNavigationController *)navigationController willPopToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)advancedNavigationController:(ANAdvancedNavigationController *)navigationController didPopToViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end





@interface ANAdvancedNavigationController : UIViewController {
    BOOL _isfirstViewControllerViewOverdraggedToLeft;
}

@property (nonatomic, retain) UIView *backgroundView;
@property (nonatomic, retain) UIViewController *leftViewController;
@property (nonatomic, readonly, copy) NSArray *rightViewControllers;

@property (nonatomic, weak) id<ANAdvancedNavigationControllerDelegate> delegate;

@property (nonatomic, readonly) BOOL isFirstViewControllerViewOverdraggedToLeft;

- (id)initWithLeftViewController:(UIViewController *)leftViewController;
- (id)initWithLeftViewController:(UIViewController *)leftViewController rightViewControllers:(NSArray *)rightViewControllers;

- (void)popViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)popViewControllersToViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)pushViewController:(UIViewController *)viewController afterViewController:(UIViewController *)afterViewController animated:(BOOL)animated;

// will set/return the viewController, that is on anchor point right
@property (nonatomic, assign) NSUInteger indexOfFrontViewController;

@end




@interface UIViewController (ANAdvancedNavigationController)
@property (nonatomic, readonly) ANAdvancedNavigationController *advancedNavigationController;
@end
