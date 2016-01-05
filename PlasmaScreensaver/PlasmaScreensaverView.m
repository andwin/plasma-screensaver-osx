//
//  PlasmaScreensaverView.m
//  PlasmaScreensaver
//
//  Created by Anders Windelhed on 05/01/16.
//  Copyright © 2016 anders. All rights reserved.
//

#import "PlasmaScreensaverView.h"

@implementation PlasmaScreensaverView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    NSBezierPath *path;
    NSRect rect;
    NSSize size;
    NSColor *color;
    float red, green, blue, alpha;
    
    size = [self bounds].size;
    
    // Calculate random width and height
    rect.size = NSMakeSize(
                           SSRandomFloatBetween(size.width / 100.0, size.width / 10.0),
                           SSRandomFloatBetween(size.height / 100.0, size.height / 10.0));
    
    // Calculate random origin point
    rect.origin = SSRandomPointForSizeWithinRect(rect.size, [self bounds]);
    
    
    path = [NSBezierPath bezierPathWithRect:rect];
    
    // Calculate a random color
    red = SSRandomFloatBetween(0.0, 255.0) / 255.0;
    green = SSRandomFloatBetween(0.0, 255.0) / 255.0;
    blue = SSRandomFloatBetween(0.0, 255.0) / 255.0;
    alpha = SSRandomFloatBetween(0.0, 255.0) / 255.0;
    
    color = [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha];
    
    [color set];
    
    [path fill];
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
