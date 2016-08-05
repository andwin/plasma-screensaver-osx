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
    [[NSGraphicsContext currentContext] setImageInterpolation: NSImageInterpolationNone];

    int width = 320;
    int height = 240;

    size_t bufferLength = width * height * 4;

    NSMutableData* data = [NSMutableData dataWithLength:bufferLength];
    char* imageData = [data mutableBytes];

    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            char red = SSRandomIntBetween(0, 255);
            char green = SSRandomIntBetween(0, 255);
            char blue = SSRandomIntBetween(0, 255);

            int pos = (y * width + x) * 4;
            imageData[pos] = red;
            imageData[pos +1] = green;
            imageData[pos +2] = blue;
            imageData[pos +3] = 255;
        }
    }

    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, imageData, bufferLength, NULL);
    size_t bitsPerComponent = 8;
    size_t bitsPerPixel = 32;
    size_t bytesPerRow = 4 * width;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;

    CGImageRef iref = CGImageCreate(width,
                                    height,
                                    bitsPerComponent,
                                    bitsPerPixel,
                                    bytesPerRow,
                                    colorSpaceRef,
                                    bitmapInfo,
                                    provider,   // data provider
                                    NULL,       // decode
                                    YES,        // should interpolate
                                    renderingIntent);

    NSImage* image = [[NSImage alloc] initWithCGImage:iref size:NSMakeSize(width, height)];

    NSSize size;
    size = [self bounds].size;

    [image drawInRect:NSMakeRect(0,0,size.width, size.height)
             fromRect:NSMakeRect(0,0,[image size].width, [image size].height)
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
