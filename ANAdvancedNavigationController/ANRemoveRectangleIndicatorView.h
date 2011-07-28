//
//  ANRemoveRectangleIndicatorView.h
//  ANAdvancedNavigationController
//
//  Created by Oliver Letterer on 29.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANRectangleView.h"

typedef enum {
    ANRemoveRectangleIndicatorViewStateHidden = 0,
    ANRemoveRectangleIndicatorViewStateVisible,
    ANRemoveRectangleIndicatorViewStateFlippedToRight,
    ANRemoveRectangleIndicatorViewStateRemovedRight
} ANRemoveRectangleIndicatorViewState;





@interface ANRemoveRectangleIndicatorView : UIView {
    ANRectangleView *_firstRectangleView;
    ANRectangleView *_secondRectangleView;
    
    ANRemoveRectangleIndicatorViewState _state;
    
    CGPoint _secondRectangleViewCenterPoint;
    CGPoint _secondRectangleViewFlippedCenterPoint;
    CGPoint _secondRectangleViewRemovedCenterPoint;
}

@property (nonatomic, retain, readonly) ANRectangleView *firstRectangleView;
@property (nonatomic, retain, readonly) ANRectangleView *secondRectangleView;

@property (nonatomic, assign) ANRemoveRectangleIndicatorViewState state;
- (void)setState:(ANRemoveRectangleIndicatorViewState)state animated:(BOOL)animated;

@end
