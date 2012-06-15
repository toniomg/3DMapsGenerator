//
//  OpenGLView.m
//  3DMapsGenerator
//
//  Created by Antonio Martinez on 6/15/12.
//  Copyright (c) 2012 AMG. All rights reserved.
//

#import "OpenGLView.h"

@implementation OpenGLView

- (void)dealloc
{
    [_context release];
    _context = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayer];        
        [self setupContext];                
        [self setupRenderBuffer];        
        [self setupFrameBuffer];                
        [self render];
    }
    return self;
}

#pragma mark Init OpenGL

/** 
 * Set up the EAGL Context
 */
- (void)setupContext {   
    EAGLRenderingAPI apiRendering = kEAGLRenderingAPIOpenGLES2;
    _context = [[EAGLContext alloc] initWithAPI:apiRendering];
    if (!_context) {
        NSLog(@"Failed to init OpenGL ES 2.0 context");
        exit(1);
    }
    
    if (![EAGLContext setCurrentContext:_context]) {
        NSLog(@"Failed to set current OpenGL ES context");
        exit(1);
    }
}

/**
 * Create the render buffer. It will store the rendered images to present to the screen
 */
- (void)setupRenderBuffer {
    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);        
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];    
}


/**
 * Create the frame buffer. It will contain all the buffers, including render buffer
 */
- (void)setupFrameBuffer {    
    GLuint framebuffer;
    glGenFramebuffers(1, &framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, 
                              GL_RENDERBUFFER, _colorRenderBuffer);
}


/**
 * Render the view
 */
-(void)render {
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

#pragma mark Layer methods

//Override the layer to make it CAEAGLLayer
+ (Class)layerClass {
    return [CAEAGLLayer class];
}

//Set it up to opaque (default is transparent)
- (void)setupLayer {
    _eaglLayer = (CAEAGLLayer*) self.layer;
    _eaglLayer.opaque = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
