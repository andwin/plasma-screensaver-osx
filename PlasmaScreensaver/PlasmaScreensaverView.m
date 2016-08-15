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
        [self setAnimationTimeInterval:1/15.0];
    }

    virtualScreenWidth = 320;
    virtualScreenHeight = 240;

    NSSize screenSize = [self bounds].size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;

    virtualPixelWidth = (float )screenWidth / (float )virtualScreenWidth;
    virtualPixelHeight = (float )screenHeight / (float )virtualScreenHeight;

    bufferLength = virtualScreenWidth * virtualScreenHeight * 4;
    data = [NSMutableData dataWithLength:bufferLength];
    imageData = [data mutableBytes];

    time = 0.0;

    [[NSGraphicsContext currentContext] setImageInterpolation: NSImageInterpolationNone];

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
    for (int y = 0; y < virtualScreenHeight; y++) {
        for (int x = 0; x < virtualScreenWidth; x++) {
            float v1 = sin((float )x / (virtualPixelWidth * 5.0f) + time * 1.02f) / 1.5f;

            float v2 = sin(((float )x * sin(time / 5.0f) / (virtualPixelWidth * 5.0f) + (float )y * cos(time / 7) / (virtualPixelHeight * 7)) + time + 100.0) / 1.9;

            float cx = x - sin(time / 9.0f) * virtualScreenWidth / 2.0f * 0.8f - virtualScreenWidth / 2.0f;
            float cy = y - sin(time / 6.0f) * virtualScreenHeight / 2.0f * 0.8f - virtualScreenHeight / 2.0f;
            float v3 = sin(sqrt((cx * cx + cy * cy) / virtualPixelWidth / 180.0f) + time) / 2.3;

            float v = (v1 + v2 + v3) / 3;
            int colors = 255;
            v = (v + 0.5f) * (float)colors;

            if (v > colors -1) v = colors -1;
            if (v < 0) v = 0;

            int pos = (y * virtualScreenWidth + x) * 4;

            imageData[pos] = v;
            imageData[pos +1] = v;
            imageData[pos +2] = v;
            imageData[pos +3] = 255;
        }
    }

    time += 0.05;

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
