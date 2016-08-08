//
//  PlasmaScreensaverView.m
//  PlasmaScreensaver
//
//  Created by Anders Windelhed on 05/01/16.
//  Copyright © 2016 anders. All rights reserved.
//

#import "PlasmaScreensaverView.h"

@implementation PlasmaScreensaverView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];

    if (self) {
        [self setAnimationTimeInterval:1/5.0];
    }

    virtualScreenWidth = 320;
    virtualScreenHeight = 240;

    NSSize screenSize = [self bounds].size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;

    virtualPixelWidth = (float )screenWidth / (float )virtualScreenWidth;
    virtualPixelHeight = (float )screenHeight / (float )virtualScreenHeight;

    time = 0.0;

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
    [[NSGraphicsContext currentContext] setImageInterpolation: NSImageInterpolationNone];

    size_t bufferLength = virtualScreenWidth * virtualScreenHeight * 4;

    NSMutableData* data = [NSMutableData dataWithLength:bufferLength];
    char* imageData = [data mutableBytes];

    for (int y = 0; y < virtualScreenHeight; y++) {
        for (int x = 0; x < virtualScreenWidth; x++) {
            float v1 = sin((float )x / (virtualPixelWidth * 5.0f) + time * 1.02f) / 1.5f;

            float v = v1;
            int colors = 255;
            v = (char )((v + 0.5) * (float)colors);

            if (v > colors -1) v = colors -1;
            if (v < 0) v = 0;

            int pos = (y * virtualScreenWidth + x) * 4;

            imageData[pos] = v;
            imageData[pos +1] = v;
            imageData[pos +2] = v;
            imageData[pos +3] = 255;

        }
    }

    time += 1.05;

    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, imageData, bufferLength, NULL);
    size_t bitsPerComponent = 8;
    size_t bitsPerPixel = 32;
    size_t bytesPerRow = 4 * virtualScreenWidth;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;

    CGImageRef iref = CGImageCreate(virtualScreenWidth,
                                    virtualScreenHeight,
                                    bitsPerComponent,
                                    bitsPerPixel,
                                    bytesPerRow,
                                    colorSpaceRef,
                                    bitmapInfo,
                                    provider,   // data provider
                                    NULL,       // decode
                                    YES,        // should interpolate
                                    renderingIntent);

    NSImage* image = [[NSImage alloc] initWithCGImage:iref size:NSMakeSize(virtualScreenWidth, virtualScreenHeight)];

    [image drawInRect:NSMakeRect(0, 0, screenWidth, screenHeight)
             fromRect:NSMakeRect(0, 0, virtualScreenWidth, virtualScreenHeight)
            operation:NSCompositeSourceOver
             fraction:1.0];
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
