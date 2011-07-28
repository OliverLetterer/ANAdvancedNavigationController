//
//  ANRectangleView.m
//  ANAdvancedNavigationController
//
//  Created by Oliver Letterer on 29.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ANRectangleView.h"

@implementation ANRectangleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    CGRect bounds = self.bounds;
    [super setFrame:frame];
    
    if (!CGRectEqualToRect(self.bounds, bounds)) {
        [self setNeedsDisplay];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat inset = 5.0f;
    UIBezierPath *roundRectPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(inset, inset, CGRectGetWidth(rect)-2.0f*inset, CGRectGetHeight(rect)-2.0f*inset) cornerRadius:10.0f];
    [[UIColor colorWithWhite:0.0f alpha:0.25f] setFill];
    
    [roundRectPath fill];
    [[UIColor whiteColor] setStroke];
    
    [roundRectPath setLineWidth:1.5f];
    [roundRectPath stroke];
}

@end
