//
//  PlasmaScreensaverView.h
//  PlasmaScreensaver
//
//  Created by Anders Windelhed on 05/01/16.
//  Copyright © 2016 anders. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>

@interface PlasmaScreensaverView : ScreenSaverView
{
    NSUInteger virtualScreenWidth;
    NSUInteger virtualScreenHeight;

    NSUInteger screenWidth;
    NSUInteger screenHeight;

    float virtualPixelWidth;
    float virtualPixelHeight;

    size_t bufferLength;
    char* imageData;

    float time;
}

@end
