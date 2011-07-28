//
//  ANRectangleView.m
//  ANAdvancedNavigationController
//
//  Created by Oliver Letterer on 29.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ANRectangleView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ANRectangleView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.layer.needsDisplayOnBoundsChange = YES;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    static CGFloat inset = 5.0f;
    UIBezierPath *roundRectPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, inset, inset) cornerRadius:10.0f];
    [[UIColor colorWithWhite:0.0f alpha:0.25f] setFill];
    
    [roundRectPath fill];
    [[UIColor whiteColor] setStroke];
    
    [roundRectPath setLineWidth:1.5f];
    [roundRectPath stroke];
}

@end
