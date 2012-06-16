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

@property (nonatomic, retain) OpenGLView *glView;

-(IBAction)addBlockPressed:(id)sender;

@end

@implementation MGViewController

@synthesize glView = _glView;

#define N_FINGERS_MOVING 1
#define N_FINGERS_ROTATING 2


#define ORIGIN_GLVIEW 200


-(void)loadView{
    
    //Create the OpenGL view and add it to this view controller
    CGRect screenBounds = [[UIScreen mainScreen] bounds];       // self.view = glView;
    self.view = [[[UIView alloc] initWithFrame:screenBounds] autorelease];
//    self.view.backgroundColor = [UIColor blueColor];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    //Add the openGL View
    self.glView = [[[OpenGLView alloc] initWithFrame:CGRectMake(ORIGIN_GLVIEW, 0,self.view.frame.size.height - ORIGIN_GLVIEW , self.view.frame.size.width)] autorelease];
    [self.view addSubview:self.glView];
    
    
    //Add the edition view
    UIView *editionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ORIGIN_GLVIEW, self.view.frame.size.width)];
    editionView.backgroundColor = [UIColor colorWithRed:0.2 green:0.8 blue:1 alpha:1];

    
    //Edition mode button
    UIButton *addBlock = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addBlock.frame = CGRectMake(ORIGIN_GLVIEW/5, 500, ORIGIN_GLVIEW - ORIGIN_GLVIEW/2.5, 50);
    [addBlock addTarget:self action:@selector(addBlockPressed:) forControlEvents:UIControlEventTouchUpInside];
    [editionView addSubview:addBlock];
    
    [self.view addSubview:editionView];
    [editionView release];

    //Add the gesture recognizer
    //Pinching for the zoom
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    
    //Draging with one finger the position, draging with two fingers for the perspective
    UIPanGestureRecognizer *dragRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDrag:)];
    dragRecognizer.minimumNumberOfTouches = N_FINGERS_MOVING;
    dragRecognizer.maximumNumberOfTouches = N_FINGERS_ROTATING;

    [self.glView addGestureRecognizer:pinchRecognizer];
    [self.glView addGestureRecognizer:dragRecognizer];
    
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

#pragma mark Button Actions

-(IBAction)addBlockPressed:(id)sender{
    
    self.glView.editModeEnabled = !self.glView.editModeEnabled;
    
    
}

@end
