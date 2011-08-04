//
//  ANRemoveRectangleIndicatorView.m
//  ANAdvancedNavigationController
//
//  Created by Oliver Letterer on 29.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ANRemoveRectangleIndicatorView.h"

static CGFloat kANRemoveRectangleIndicatorViewAnimationDuration = 0.15f;

@implementation ANRemoveRectangleIndicatorView
@synthesize firstRectangleView=_firstRectangleView, secondRectangleView=_secondRectangleView, state=_state;

- (void)setState:(ANRemoveRectangleIndicatorViewState)state {
    [self setState:state animated:NO];
}

- (void)setState:(ANRemoveRectangleIndicatorViewState)state animated:(BOOL)animated {
    if (state != _state) {
        __block CGFloat animationDuration = kANRemoveRectangleIndicatorViewAnimationDuration;
        void(^animationBlock)(void) = ^(void) {
            switch (state) {
                case ANRemoveRectangleIndicatorViewStateHidden:
                    self.alpha = 0.0f;
                    _secondRectangleView.center = _secondRectangleViewCenterPoint;
                    _secondRectangleView.transform = CGAffineTransformIdentity;
                    _secondRectangleView.alpha = 1.0f;
                    break;
                case ANRemoveRectangleIndicatorViewStateVisible:
                    self.alpha = 1.0f;
                    _secondRectangleView.center = _secondRectangleViewCenterPoint;
                    _secondRectangleView.transform = CGAffineTransformIdentity;
                    _secondRectangleView.alpha = 1.0f;
                    break;
                case ANRemoveRectangleIndicatorViewStateFlippedToRight:
                    self.alpha = 1.0f;
                    _secondRectangleView.center = _secondRectangleViewFlippedCenterPoint;
                    _secondRectangleView.transform = CGAffineTransformMakeRotation(M_PI / 8.0f);
                    _secondRectangleView.alpha = 0.5f;
                    break;
                case ANRemoveRectangleIndicatorViewStateRemovedRight:
                    self.alpha = 1.0f;
                    _secondRectangleView.center = _secondRectangleViewRemovedCenterPoint;
                    _secondRectangleView.transform = CGAffineTransformMakeRotation(M_PI / 2.0f);
                    _secondRectangleView.alpha = 0.5f;
                    break;
                default:
                    break;
            }
        };
        
        _state = state;
        if (animated) {
            [UIView animateWithDuration:animationDuration 
                             animations:animationBlock];
        } else {
            animationBlock();
        }
    }
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        static CGFloat topOffset = 20.0f;
        CGFloat width = CGRectGetWidth(self.bounds)/2.5f;
        self.backgroundColor = [UIColor clearColor];
        _firstRectangleView = [[ANRectangleView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, CGRectGetHeight(self.bounds)-topOffset)];
        [self addSubview:_firstRectangleView];
        
        _secondRectangleView = [[ANRectangleView alloc] initWithFrame:CGRectMake(width/2.0f, topOffset, width, CGRectGetHeight(self.bounds)-20.0f)];
        _secondRectangleViewCenterPoint = _secondRectangleView.center;
        _secondRectangleViewFlippedCenterPoint = CGPointMake(_secondRectangleViewCenterPoint.x + 80.0f, _secondRectangleViewCenterPoint.y + 30.0f);
        _secondRectangleViewRemovedCenterPoint = CGPointMake(_secondRectangleViewFlippedCenterPoint.x + 10.0f, _secondRectangleViewFlippedCenterPoint.y + 150.0f);
        [self addSubview:_secondRectangleView];
        
        self.state = ANRemoveRectangleIndicatorViewStateHidden;
        self.alpha = 0.0f;
    }
    return self;
}

@end
