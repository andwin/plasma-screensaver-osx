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

    NSSize size;
    size = [self bounds].size;
    screenWidth = size.width;
    screenHeight = size.height;
    
    virtualScreenWidth = 320;
    virtualScreenHeight = 240;
    
    virtualPixelWidth = (float )screenWidth / (float )virtualScreenWidth;
    virtualPixelHeight = (float )screenHeight / (float )virtualScreenHeight;

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
    for (int x = 0; x < virtualScreenWidth; x++) {
        for (int y = 0; y < virtualScreenHeight; y++) {
            float red = SSRandomFloatBetween(0.0, 255.0) / 255.0;
            float green = SSRandomFloatBetween(0.0, 255.0) / 255.0;
            float blue = SSRandomFloatBetween(0.0, 255.0) / 255.0;
            
            [self drawPixel:x y:y red:red green:green blue:blue];
        }
    }
}

- (void)drawPixel:(NSUInteger) x y:(NSUInteger) y red:(float) red green:(float) green blue:(float) blue
{
    NSRect rect;
    rect.size = NSMakeSize(virtualPixelWidth, virtualPixelHeight);
    rect.origin = NSMakePoint((float)x * virtualPixelWidth, (float)y * virtualPixelHeight);
    
    NSBezierPath *path;
    path = [NSBezierPath bezierPathWithRect:rect];
    
    NSColor *color;
    color = [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:1];
    
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
