//
//  PlasmaScreensaverView.h
//  PlasmaScreensaver
//
//  Created by Anders Windelhed on 05/01/16.
//  Copyright © 2016 anders. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import <OpenGL/gl.h>
#import <OpenGL/glu.h>

@interface PlasmaScreensaverView : ScreenSaverView
{
    NSOpenGLView *glView;
    GLfloat rotation;
}

- (void)setUpOpenGL;

@end
