//
//  MGViewController.m
//  3DMapsGenerator
//
//  Created by M2Mobi on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGViewController.h"
#import "OpenGLView.h"

@interface MGViewController ()

@end

@implementation MGViewController

#define N_FINGERS_MOVING 1
#define N_FINGERS_ROTATING 2


-(void)loadView{
    
    //Create the OpenGL view and add it to this view controller
    CGRect screenBounds = [[UIScreen mainScreen] bounds];    
    OpenGLView *glView = [[[OpenGLView alloc] initWithFrame:screenBounds] autorelease];
    self.view = glView;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //Add the gesture recognizer
    //Pinching for the zoom
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    
    //Draging with one finger the position, draging with two fingers for the perspective
    UIPanGestureRecognizer *dragRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDrag:)];
    dragRecognizer.minimumNumberOfTouches = N_FINGERS_MOVING;
    dragRecognizer.maximumNumberOfTouches = N_FINGERS_ROTATING;

    [self.view addGestureRecognizer:pinchRecognizer];
    [self.view addGestureRecognizer:dragRecognizer];
    
    [pinchRecognizer release];
    [dragRecognizer release];
    
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


#pragma mark Gesture Recognizers

-(IBAction)handlePinch:(id)sender{
    
    UIPinchGestureRecognizer *pinchGesture = (UIPinchGestureRecognizer *)sender;
    
    NSLog(@"%f", pinchGesture.scale);
    
    ((OpenGLView *)self.view).zoom = pinchGesture.scale;
}

-(IBAction)handleDrag:(id)sender{
    
    UIPanGestureRecognizer *dragGesture = (UIPanGestureRecognizer *)sender;
    
    NSLog(@"%@", NSStringFromCGPoint([dragGesture translationInView:self.view]));
    
    switch (dragGesture.numberOfTouches) {
        case N_FINGERS_MOVING:{
    
            break;
        }
            
            
        case N_FINGERS_ROTATING:{
            //TODO
            break;
        }
            
        default:
            break;
    }
    
}

@end
