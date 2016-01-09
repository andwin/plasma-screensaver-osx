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
    NSUInteger screenWidth;
    NSUInteger screenHeight;

    NSUInteger virtualScreenWidth;
    NSUInteger virtualScreenHeight;

    float virtualPixelWidth;
    float virtualPixelHeight;
}

@end
