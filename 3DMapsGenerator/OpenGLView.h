//
//  OpenGLView.h
//  3DMapsGenerator
//
//  Created by M2Mobi on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

@class Block;


@interface OpenGLView : UIView {
    
    CAEAGLLayer* _eaglLayer;
    EAGLContext* _context;
    GLuint _colorRenderBuffer;
    
}


@property (assign) float zoom;
@property (assign) BOOL editModeEnabled;
@property (assign) float rotationY;
@property (assign) float rotationX;

-(void)addNewBlock:(Block *)block;

@end
